{
  pkgs,
  stdenv,
  ...
}:
stdenv.mkDerivation rec {
  pname = "lovelace-horizon-card";
  version = "1.3.1";

  src = pkgs.fetchurl {
    url = "https://github.com/rejuvenate/lovelace-horizon-card/releases/download/v${version}/lovelace-horizon-card.js";
    sha256 = "sha256-uC1LIgHPspLJTPIELLlj5n0OQHnuOkZIqaG6ds5EzB4=";
  };

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out
    cp $src $out/${pname}.js
  '';
}
