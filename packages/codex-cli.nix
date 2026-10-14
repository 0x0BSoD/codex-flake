{
  lib,
  stdenvNoCC,
  fetchurl,
}:

let
  version = "0.162.1";
  sources = {
    x86_64-linux = {
      target = "x86_64-unknown-linux-musl";
      hash = "sha256-pnb1ciquDYbL43ZDMvCOqx/didwKMAs61P+/SGEfo+M=";
    };
    aarch64-linux = {
      target = "aarch64-unknown-linux-musl";
      hash = "sha256-U6nOC5S+snpj/esvdwTZUZnheziYqjO2BGGhqTrA2Is=";
    };
  };
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
