# codex-flake

Personal Nix flake packaging OpenAI's official Linux artifacts:

- `codex-cli`: the official standalone Codex release
- `chatgpt-desktop`: the official Linux `.deb` repackaged for NixOS

Both packages support `x86_64-linux` and `aarch64-linux`.

## NixOS module

Add the flake as an input and import its module:

```nix
{
  inputs.codex.url = "github:0x0bsod/codex-flake";

  outputs = { nixpkgs, codex, ... }: {
    nixosConfigurations.my-host = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        codex.nixosModules.default
        {
          programs.openai-codex = {
            cli = true;
            desktop = true;
          };
        }
      ];
    };
  };
}
```

The only module options are the two booleans `cli` and `desktop`; both default
to `false`.

## Standalone use

```console
nix run .#codex-cli
nix build .#chatgpt-desktop
```

The artifacts use immutable, versioned OpenAI release/repository URLs and pinned
hashes so Nix builds remain reproducible.

## Updating package versions

Check whether either official OpenAI channel has a newer release:

```console
nix run .#update -- --check
```

The check exits with status `1` when an update is available, which makes it
suitable for CI. Apply all available updates with:

```console
nix run .#update
```

To operate on only one package, pass `--cli` or `--desktop`. The updater reads
OpenAI's CLI release metadata and Debian repository indexes, verifies that both
desktop architectures have the same version, and atomically rewrites
`packages/versions.nix` with the new versions and hashes. Review and build the
result before committing it.
