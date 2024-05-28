{pkgs, ...}: let
  orcaslicer = pkgs.appimageTools.wrapType2 rec {
    name = "OrcaSlicer";
    pname = "orcaslicer";
    version = "2.0.0";
    src = pkgs.fetchurl {
      url = "https://github.com/SoftFever/OrcaSlicer/releases/download/v${version}/OrcaSlicer_Linux_V${version}.AppImage";
      sha256 = "sha256-PcCsqF1RKdSrbdp1jCF0n5Mu30EniaBEuJNw3XdPhO4=";
    };
    extraPkgs = pkgs: with pkgs; [webkitgtk];
  };

  orcaslicer-desktop = pkgs.writeTextDir "share/applications/OrcaSlicer.desktop" ''
    [Desktop Entry]
    Version=2.0.0
    Type=Application
    Name=OrcaSlicer
    Exec=OrcaSlicer
  '';
in {
  home.packages = [
    orcaslicer
    orcaslicer-desktop
  ];
}
