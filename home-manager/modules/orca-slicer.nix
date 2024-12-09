{pkgs, ...}: let
  orcaslicer = pkgs.appimageTools.wrapType2 rec {
    name = "OrcaSlicer";
    pname = "orca-slicer";
    version = "2.2.0";
    src = pkgs.fetchurl {
      url = "https://github.com/SoftFever/OrcaSlicer/releases/download/v${version}/OrcaSlicer_Linux_V${version}.AppImage";
      sha256 = "sha256-3uqA3PXTrrOE0l8ziRAtmQ07gBFB+1Zx3S6JhmOPrZ8=";
    };
    extraPkgs = pkgs: with pkgs; [webkitgtk_4_1];
  };
in {
  home.packages = [
    orcaslicer
  ];
}
