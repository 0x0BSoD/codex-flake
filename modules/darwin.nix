self:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.programs.openai-codex;
  packages = self.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  options.programs.openai-codex = {
    cli = lib.mkEnableOption "the official OpenAI Codex CLI";
    desktop = lib.mkEnableOption "the official ChatGPT desktop app for macOS";
  };

  config = lib.mkIf (cfg.cli || cfg.desktop) {
    environment.systemPackages =
      lib.optional cfg.cli packages.codex-cli ++ lib.optional cfg.desktop packages.chatgpt-desktop;
  };
}
