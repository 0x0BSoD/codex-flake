{
  description = "OpenAI Codex CLI and ChatGPT desktop app for NixOS";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
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
        in
        rec {
          codex-cli = pkgs.callPackage ./packages/codex-cli.nix { };
          chatgpt-desktop = pkgs.callPackage ./packages/chatgpt-desktop.nix { };
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

      formatter = forAllSystems (system: (pkgsFor system).nixfmt);

      checks = forAllSystems (system: {
        inherit (self.packages.${system}) codex-cli chatgpt-desktop;
      });
    };
}
