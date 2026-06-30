{
  pkgs,
  stdenv,
  ...
}:
stdenv.mkDerivation rec {
  pname = "lovelace-vacuum-mop-card";
  version = "2.3.2";

  src = pkgs.fetchurl {
    url = "https://github.com/PiotrMachowski/lovelace-xiaomi-vacuum-map-card/releases/download/v${version}/xiaomi-vacuum-map-card.js";
    sha256 = "sha256-q7VCN9EgbiEV/pmuTelRWLS+QMUzuGeSXvnttFfWiuA=";
  };

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out
    cp $src $out/${pname}.js
  '';
}
