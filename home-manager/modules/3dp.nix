{ pkgs, ... }:
let
  # orcaslicer = pkgs.appimageTools.wrapType2 rec {
  #   name = "OrcaSlicer";
  #   pname = "orcaslicer";
  #   version = "1.6.4";
  #   src = let
  #     extracted = pkgs.fetchzip {
  #       url =
  # 			"https://github.com/SoftFever/OrcaSlicer/releases/download/v${version}/OrcaSlicer_Linux_V${version}.zip";
  # 		# sha256 = "sha256-f38nXjj2X8bhClFGbVYKKB6Q5daEe/D/k1MdjgKAIgU=";
  #     };
  #   in "${extracted}/OrcaSlicer_ubu64.AppImage";
  #   extraPkgs = pkgs: with pkgs; [ webkitgtk ];
  # };

  orcaslicer = pkgs.appimageTools.wrapType2 rec {
    name = "OrcaSlicer";
    pname = "orcaslicer";
    version = "1.7.0";
    src = pkgs.fetchurl {
      url =
        "https://github.com/SoftFever/OrcaSlicer/releases/download/v${version}/OrcaSlicer_Linux_V${version}.AppImage";
      sha256 = "sha256-5Ag+pZBsOULp2Kk0KVG/P2ZQ/UVZm7zJZ4B2eXNeS50=";
    };
    extraPkgs = pkgs: with pkgs; [ webkitgtk ];
  };

  bambu-studio = pkgs.appimageTools.wrapType2 rec {
    name = "BambuStudio";
    pname = "bambustudio";
    version = "1.7.6";
    src = pkgs.fetchurl {
      url =
        "https://github.com/bambulab/BambuStudio/releases/download/v01.07.06.92/Bambu_Studio_linux_ubuntu_v01.07.06.92-20230923002726.AppImage";
      sha256 = "sha256-P0HkmrlO+QyNkhcZkxZOML7rDA9uSZu8CnX+U3CVutU=";
    };
    extraPkgs = pkgs: with pkgs; [ webkitgtk ];
  };

  orcaslicer-desktop = pkgs.writeTextDir "share/applications/OrcaSlicer.desktop"
    "	[Desktop Entry]\n	Version=1.7.0\n	Type=Application\n	Name=OrcaSlicer\n	Exec=OrcaSlicer\n";
in {
  home.packages =
    [ pkgs.prusa-slicer orcaslicer orcaslicer-desktop bambu-studio ];
}
