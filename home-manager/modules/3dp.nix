{ pkgs, ... }:
let
  orcaslicer = pkgs.appimageTools.wrapType2 rec {
    name = "OrcaSlicer";
    pname = "orcaslicer";
    version = "1.6.3";
    src = let
      extracted = pkgs.fetchzip {
        url =
          "https://github.com/SoftFever/OrcaSlicer/releases/download/v${version}/OrcaSlicer_V1.6.3_Linux.zip";
        sha256 = "sha256-n/D0qfli+kPPKgDIujsPdZHdoUPex3SFuSqLlhGzxJY=";
      };
    in "${extracted}/OrcaSlicer_ubu64.AppImage";
    extraPkgs = pkgs: with pkgs; [ webkitgtk ];
  };
  orcaslicer-desktop = pkgs.writeTextDir "share/applications/OrcaSlicer.desktop"
    "	[Desktop Entry]\n	Version=1.6.3\n	Type=Application\n	Name=OrcaSlicer\n	Exec=OrcaSlicer\n";
in { home.packages = [ pkgs.prusa-slicer orcaslicer orcaslicer-desktop ]; }
