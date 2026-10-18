{
  lib,
  stdenvNoCC,
  fetchurl,
  unzip,
}:

let
  release = (import ./versions.nix).desktop;
  inherit (release) version sources;
  source =
    sources.${stdenvNoCC.hostPlatform.system}
      or (throw "chatgpt-desktop: unsupported system ${stdenvNoCC.hostPlatform.system}");
in
stdenvNoCC.mkDerivation {
  pname = "chatgpt-desktop";
  inherit version;

  src = fetchurl {
    url = "https://persistent.oaistatic.com/codex-app-prod/ChatGPT-darwin-arm64-${version}.zip";
    inherit (source) hash;
  };

  nativeBuildInputs = [ unzip ];

  sourceRoot = ".";
  # Any post-install rewriting, including shebang patching, invalidates the
  # app's nested code signatures and causes Gatekeeper to reject the bundle.
  dontFixup = true;

  installPhase = ''
    runHook preInstall
    mkdir -p "$out/Applications" "$out/bin"
    cp -a ChatGPT.app "$out/Applications/"
    ln -s "$out/Applications/ChatGPT.app/Contents/MacOS/ChatGPT" "$out/bin/chatgpt"
    runHook postInstall
  '';

  meta = {
    description = "Official ChatGPT desktop app for macOS";
    homepage = "https://learn.chatgpt.com/docs/app";
    license = lib.licenses.unfree;
    mainProgram = "chatgpt";
    platforms = [ "aarch64-darwin" ];
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
  };
}
