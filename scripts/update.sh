#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: update [--check] [--cli | --desktop]

Checks OpenAI's official release metadata. Without --check, updates
packages/versions.nix atomically. By default both packages are checked.

  --check    Report updates and exit 1 when versions.nix is outdated
  --cli      Check/update only the Codex CLI
  --desktop  Check/update only the ChatGPT desktop app
EOF
}

check_only=false
update_cli=false
update_desktop=false

while (($#)); do
  case "$1" in
    --check) check_only=true ;;
    --cli) update_cli=true ;;
    --desktop) update_desktop=true ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown argument: $1" >&2; usage >&2; exit 2 ;;
  esac
  shift
done

if ! $update_cli && ! $update_desktop; then
  update_cli=true
  update_desktop=true
fi

repo_root=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
versions_file="$repo_root/packages/versions.nix"
[[ -f "$versions_file" ]] || { echo "Cannot find $versions_file" >&2; exit 2; }

nix_value() {
  nix --extra-experimental-features nix-command eval --raw --file "$versions_file" "$1"
}

cli_version=$(nix_value cli.version)
cli_x86_hash=$(nix_value cli.sources.x86_64-linux.hash)
cli_arm_hash=$(nix_value cli.sources.aarch64-linux.hash)
cli_darwin_arm_hash=$(nix_value cli.sources.aarch64-darwin.hash)
desktop_version=$(nix_value desktop.version)
desktop_x86_hash=$(nix_value desktop.sources.x86_64-linux.hash)
desktop_arm_hash=$(nix_value desktop.sources.aarch64-linux.hash)
desktop_darwin_arm_hash=$(nix_value desktop.sources.aarch64-darwin.hash)

hex_to_sri() {
  nix --extra-experimental-features nix-command hash convert --hash-algo sha256 --to sri "$1"
}

if $update_cli; then
  metadata=$(curl --fail --silent --show-error --location \
    https://releases.openai.com/codex/channels/latest)
  new_cli_version=$(jq -er '.tag_name | sub("^rust-v"; "")' <<<"$metadata")
  cli_version=$new_cli_version

  cli_digest() {
    local target=$1
    jq -er --arg name "codex-package-$target.tar.gz" \
      '.assets[] | select(.name == $name) | .digest | sub("^sha256:"; "")' \
      <<<"$metadata"
  }

  cli_x86_hash=$(hex_to_sri "$(cli_digest x86_64-unknown-linux-musl)")
  cli_arm_hash=$(hex_to_sri "$(cli_digest aarch64-unknown-linux-musl)")
  cli_darwin_arm_hash=$(hex_to_sri "$(cli_digest aarch64-apple-darwin)")
fi

desktop_record() {
  local arch=$1
  curl --fail --silent --show-error --location \
    "https://persistent.oaistatic.com/codex-app-prod/linux/deb/dists/stable/main/binary-$arch/Packages.gz" |
    gzip -dc |
    awk '
      $1 == "Package:" && $2 == "chatgpt" { found = 1 }
      found && $1 == "Version:" { version = $2 }
      found && !printed && $1 == "SHA256:" { print version, $2; printed = 1 }
    '
}

desktop_macos_record() {
  curl --fail --silent --show-error --location \
    "https://persistent.oaistatic.com/codex-app-prod/appcast.xml" |
    awk '
      match($0, /<sparkle:shortVersionString>([^<]+)<\/sparkle:shortVersionString>/, version) {
        latest = version[1]
      }
      !printed && latest != "" && match($0, /enclosure url="([^"]*ChatGPT-darwin-arm64-[^"]+\.zip)"/, source) {
        print latest, source[1]
        printed = 1
      }
    '
}

if $update_desktop; then
  read -r new_desktop_version desktop_x86_hex <<<"$(desktop_record amd64)"
  read -r desktop_arm_version desktop_arm_hex <<<"$(desktop_record arm64)"
  read -r desktop_darwin_version desktop_darwin_url <<<"$(desktop_macos_record)"
  [[ -n "$new_desktop_version" && -n "$desktop_x86_hex" ]] || {
    echo "Could not read the amd64 desktop package metadata" >&2; exit 1;
  }
  [[ "$new_desktop_version" == "$desktop_arm_version" ]] || {
    echo "Desktop repository versions differ: amd64=$new_desktop_version arm64=$desktop_arm_version" >&2
    exit 1
  }
  [[ "$new_desktop_version" == "$desktop_darwin_version" ]] || {
    echo "Desktop repository versions differ: linux=$new_desktop_version macOS=$desktop_darwin_version" >&2
    exit 1
  }
  if ! $check_only && [[ "$new_desktop_version" != "$desktop_version" ]]; then
    desktop_darwin_arm_hash=$(
      nix --extra-experimental-features nix-command store prefetch-file --json "$desktop_darwin_url" |
        jq -er .hash
    )
  fi
  desktop_version=$new_desktop_version
  desktop_x86_hash=$(hex_to_sri "$desktop_x86_hex")
  desktop_arm_hash=$(hex_to_sri "$desktop_arm_hex")
fi

old_cli_version=$(nix_value cli.version)
old_desktop_version=$(nix_value desktop.version)
changed=false
if $update_cli; then
  if [[ "$cli_version" != "$old_cli_version" ]]; then
    echo "Codex CLI: $old_cli_version -> $cli_version"
    changed=true
  else
    echo "Codex CLI: $old_cli_version (current)"
  fi
fi
if $update_desktop; then
  if [[ "$desktop_version" != "$old_desktop_version" ]]; then
    echo "ChatGPT desktop: $old_desktop_version -> $desktop_version"
    changed=true
  else
    echo "ChatGPT desktop: $old_desktop_version (current)"
  fi
fi

if $check_only; then
  $changed && exit 1
  exit 0
fi

tmp=$(mktemp "$repo_root/packages/.versions.nix.XXXXXX")
trap 'rm -f "$tmp"' EXIT
cat >"$tmp" <<EOF
{
  cli = {
    version = "$cli_version";
    sources = {
      x86_64-linux = {
        target = "x86_64-unknown-linux-musl";
        hash = "$cli_x86_hash";
      };
      aarch64-linux = {
        target = "aarch64-unknown-linux-musl";
        hash = "$cli_arm_hash";
      };
      aarch64-darwin = {
        target = "aarch64-apple-darwin";
        hash = "$cli_darwin_arm_hash";
      };
    };
  };

  desktop = {
    version = "$desktop_version";
    sources = {
      x86_64-linux = {
        arch = "amd64";
        hash = "$desktop_x86_hash";
      };
      aarch64-linux = {
        arch = "arm64";
        hash = "$desktop_arm_hash";
      };
      aarch64-darwin = {
        hash = "$desktop_darwin_arm_hash";
      };
    };
  };
}
EOF
mv "$tmp" "$versions_file"
trap - EXIT

if $changed; then
  echo "Updated packages/versions.nix"
else
  echo "No update needed"
fi
