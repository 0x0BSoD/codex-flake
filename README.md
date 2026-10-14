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

## Home Manager

Home Manager can consume the package outputs directly, without importing the
NixOS module:

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    codex.url = "github:0x0bsod/codex-flake";
  };

  outputs = { nixpkgs, home-manager, codex, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations.alex = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [{
          home = {
            username = "alex";
            homeDirectory = "/home/alex";
            stateVersion = "26.05";
            packages = with codex.packages.${system}; [
              codex-cli
              chatgpt-desktop
            ];
          };
        }];
      };
    };
}
```

Remove either package from `home.packages` when only the CLI or desktop app is
wanted. For release-based deployments, append a tag such as `/v0.1.0` to the
`codex.url` after publishing that tag.

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
