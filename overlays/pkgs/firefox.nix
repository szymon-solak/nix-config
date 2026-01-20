{
  stdenv,
  fetchurl,
  undmg,
  unzip,
  lib,
  ...
}: let
  version = "137.0";
in
  stdenv.mkDerivation rec {
    inherit version;

    name = "Firefox-${version}";
    buildInputs = [undmg unzip];
    sourceRoot = ".";
    phases = ["unpackPhase" "installPhase"];
    installPhase = ''
      mkdir -p "$out/Applications"
      cp -r Firefox.app "$out/Applications/Firefox.app"
    '';

    src = fetchurl {
      name = "Firefox-${version}.dmg";
      url = "https://download-installer.cdn.mozilla.net/pub/firefox/releases/${version}/mac/en-GB/Firefox%20${version}.dmg";
      sha256 = "sha256-tJMgU6IOjXzjT74FXr2+D9QeV3CdOs/okgJcRoF1a00=";
    };

    meta = {
      description = "The Firefox web browser";
      homepage = "https://www.mozilla.org/en-GB/firefox";
      platforms = lib.platforms.darwin;
    };
  }
