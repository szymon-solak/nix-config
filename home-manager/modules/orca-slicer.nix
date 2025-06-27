{pkgs, ...}: let
  orcaslicer = pkgs.appimageTools.wrapType2 rec {
    name = "OrcaSlicer";
    pname = "orca-slicer";
    version = "2.3.0";
    src = pkgs.fetchurl {
      url = "https://github.com/SoftFever/OrcaSlicer/releases/download/v${version}/OrcaSlicer_Linux_AppImage_V${version}.AppImage";
      sha256 = "sha256-cwediOw28GFdt5GdAKom/jAeNIum4FGGKnz8QEAVDAM=";
    };
    extraPkgs = pkgs: with pkgs; [webkitgtk_4_0];
  };

  orcaslicer-desktop =
    pkgs.writeTextDir "share/applications/OrcaSlicer.desktop"
    ''
      [Desktop Entry]
      Version=2.0.0
      Type=Application
      Name=OrcaSlicer
      Exec=orca-slicer
    '';
in {
  home.packages = [
    orcaslicer
    orcaslicer-desktop
  ];
}
