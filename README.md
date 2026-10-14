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
