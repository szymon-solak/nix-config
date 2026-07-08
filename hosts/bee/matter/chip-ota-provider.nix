{
  stdenv,
  fetchurl,
  lib,
  libnl,
  ...
}:
stdenv.mkDerivation rec {
  name = "matter-linux-ota-provider-${version}";
  version = "2025.9.0";
  sourceRoot = ".";

  src = fetchurl {
    url = "https://github.com/home-assistant-libs/matter-linux-ota-provider/releases/download/${version}/chip-ota-provider-app-x86-64";
    sha256 = "sha256-RVDfevZSnkYgRj0cASf4MOwkBMgXrUxjQ7KeMs7AFE4=";
  };

  dontUnpack = true;

  installPhase = ''
    ls -la $src
    install -m755 -D $src $out/bin/chip-ota-provider-app
  '';

  postFixup = ''
        patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" $out/bin/chip-ota-provider-app
    patchelf --set-rpath "${
      lib.makeLibraryPath [
        stdenv.cc.cc
        libnl
      ]
    }" $out/bin/chip-ota-provider-app
  '';
}
