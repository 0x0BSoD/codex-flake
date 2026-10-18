self:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.programs.openai-codex;
  package = self.packages.${pkgs.stdenv.hostPlatform.system}.codex-cli;
in
{
  options.programs.openai-codex.cli = lib.mkEnableOption "the official OpenAI Codex CLI";

  config = lib.mkIf cfg.cli {
    environment.systemPackages = [ package ];
  };
}
