{
  pkgs,
  stdenv,
  ...
}:
stdenv.mkDerivation rec {
  pname = "lovelace-vacuum-mop-card";
  version = "2.3.1";

  src = pkgs.fetchurl {
    url = "https://github.com/PiotrMachowski/lovelace-xiaomi-vacuum-map-card/releases/download/v${version}/xiaomi-vacuum-map-card.js";
    sha256 = "sha256-d2O9G20BARHzQ35es4SmSnyWxgxTM2gEALwQfm0GTX8=";
  };

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out
    cp $src $out/${pname}.js
  '';
}
