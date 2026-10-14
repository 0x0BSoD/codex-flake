{
  lib,
  stdenvNoCC,
  fetchurl,
}:

let
  release = (import ./versions.nix).cli;
  inherit (release) version sources;
  source =
    sources.${stdenvNoCC.hostPlatform.system}
      or (throw "codex-cli: unsupported system ${stdenvNoCC.hostPlatform.system}");
in
stdenvNoCC.mkDerivation {
  pname = "codex-cli";
  inherit version;

  src = fetchurl {
    url = "https://releases.openai.com/codex/releases/${version}/codex-package-${source.target}.tar.gz";
    inherit (source) hash;
  };

  sourceRoot = ".";
  installPhase = ''
    runHook preInstall
    mkdir -p "$out"
    cp -R . "$out/"
    runHook postInstall
  '';

  meta = {
    description = "OpenAI Codex command-line coding agent";
    homepage = "https://developers.openai.com/codex/cli";
    license = lib.licenses.asl20;
    mainProgram = "codex";
    platforms = builtins.attrNames sources;
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
  };
}
