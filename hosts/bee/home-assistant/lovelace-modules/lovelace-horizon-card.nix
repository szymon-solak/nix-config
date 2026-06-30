{
  pkgs,
  stdenv,
  ...
}:
stdenv.mkDerivation rec {
  pname = "lovelace-horizon-card";
  version = "1.4.0";

  src = pkgs.fetchurl {
    url = "https://github.com/rejuvenate/lovelace-horizon-card/releases/download/v${version}/lovelace-horizon-card.js";
    sha256 = "sha256-kdtSFDQYP4y3KZ340Q+22XeUrv14+TvHG8QuCf5vFOI=";
  };

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out
    cp $src $out/${pname}.js
  '';
}
