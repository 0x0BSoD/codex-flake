{
  description = "OpenAI Codex CLI for NixOS and macOS, plus the ChatGPT desktop app for NixOS";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
      pkgsFor =
        system:
        import nixpkgs {
          inherit system;
          config.allowUnfreePredicate = pkg: nixpkgs.lib.getName pkg == "chatgpt-desktop";
        };
    in
    {
      packages = forAllSystems (
        system:
        let
          pkgs = pkgsFor system;
          codex-cli = pkgs.callPackage ./packages/codex-cli.nix { };
        in
        {
          inherit codex-cli;
          update = pkgs.writeShellApplication {
            name = "update";
            runtimeInputs = with pkgs; [
              coreutils
              curl
              gawk
              gitMinimal
              gzip
              jq
              nix
            ];
            text = builtins.readFile ./scripts/update.sh;
          };
          default = codex-cli;
        }
        // pkgs.lib.optionalAttrs pkgs.stdenv.hostPlatform.isLinux {
          chatgpt-desktop = pkgs.callPackage ./packages/chatgpt-desktop.nix { };
        }
      );

      apps = forAllSystems (system: {
        update = {
          type = "app";
          program = "${self.packages.${system}.update}/bin/update";
          meta.description = "Update the pinned official OpenAI packages";
        };
      });

      nixosModules.default = import ./modules/nixos.nix self;
      nixosModules.codex = self.nixosModules.default;

      darwinModules.default = import ./modules/darwin.nix self;
      darwinModules.codex = self.darwinModules.default;

      formatter = forAllSystems (system: (pkgsFor system).nixfmt);

      checks = forAllSystems (
        system:
        {
          inherit (self.packages.${system}) codex-cli;
        }
        // nixpkgs.lib.optionalAttrs (nixpkgs.lib.hasSuffix "-linux" system) {
          inherit (self.packages.${system}) chatgpt-desktop;
        }
      );
    };
}
