{
  lib,
  stdenv,
  fetchurl,
  dpkg,
  asar,
  autoPatchelfHook,
  alsa-lib,
  at-spi2-core,
  cairo,
  cups,
  dbus,
  expat,
  glib,
  gtk3,
  libdrm,
  libgbm,
  libnotify,
  libusb1,
  libxkbcommon,
  mesa,
  nspr,
  nss,
  openssl,
  pango,
  systemd,
  tpm2-tss,
  libx11,
  libxcomposite,
  libxdamage,
  libxext,
  libxfixes,
  libxrandr,
  libxcb,
}:

let
  release = (import ./versions.nix).desktop;
  inherit (release) version sources;
  source =
    sources.${stdenv.hostPlatform.system}
      or (throw "chatgpt-desktop: unsupported system ${stdenv.hostPlatform.system}");
in
stdenv.mkDerivation {
  pname = "chatgpt-desktop";
  inherit version;

  src = fetchurl {
    url = "https://persistent.oaistatic.com/codex-app-prod/linux/deb/pool/main/c/chatgpt/chatgpt_${version}_${source.arch}.deb";
    inherit (source) hash;
  };

  nativeBuildInputs = [
    dpkg
    asar
    autoPatchelfHook
  ];
  buildInputs = [
    alsa-lib
    at-spi2-core
    cairo
    cups
    dbus
    expat
    glib
    gtk3
    libdrm
    libgbm
    libnotify
    libusb1
    libxkbcommon
    mesa
    nspr
    nss
    openssl
    pango
    systemd
    tpm2-tss
    libx11
    libxcomposite
    libxdamage
    libxext
    libxfixes
    libxrandr
    libxcb
  ];

  unpackPhase = ''
    runHook preUnpack
    dpkg-deb -x "$src" .
    # patchelf can relocate PT_INTERP beyond detect-libc's 2 KiB read window.
    # NixOS also lacks /usr/bin/ldd, so @parcel/watcher otherwise falls back
    # to process.report.getReport(), which traps in the bundled Node worker.
    asar extract usr/lib/chatgpt/resources/app.asar app-asar
    substituteInPlace app-asar/node_modules/@parcel/watcher/node_modules/detect-libc/lib/filesystem.js \
      --replace-fail "'/usr/bin/ldd'" "'${lib.getBin stdenv.cc.libc}/bin/ldd'"
    asar pack app-asar usr/lib/chatgpt/resources/app.asar --unpack '*.node'
    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p "$out"
    cp -R usr/* "$out/"
    substituteInPlace "$out/share/applications/chatgpt.desktop" \
      --replace-fail 'Exec=chatgpt %U' "Exec=$out/bin/chatgpt %U"
    runHook postInstall
  '';

  # Chromium loads these dynamically rather than through ELF DT_NEEDED entries.
  runtimeDependencies = [
    libgbm
    mesa
  ];
  # The Qt shims are optional desktop-integration adapters. The app uses GTK
  # when neither Qt runtime is installed.
  autoPatchelfIgnoreMissingDeps = [
    "libcuda.so.1"
    "libQt5Core.so.5"
    "libQt5Gui.so.5"
    "libQt5Widgets.so.5"
    "libQt6Core.so.6"
    "libQt6Gui.so.6"
    "libQt6Widgets.so.6"
    # The DEB contains both glibc and musl variants of a few Node addons.
    "libc.musl-x86_64.so.1"
    "libc.musl-aarch64.so.1"
  ];

  meta = {
    description = "Official ChatGPT desktop app for Linux (preview)";
    homepage = "https://learn.chatgpt.com/docs/linux/linux-app";
    license = lib.licenses.unfree;
    mainProgram = "chatgpt";
    platforms = builtins.attrNames sources;
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
  };
}
