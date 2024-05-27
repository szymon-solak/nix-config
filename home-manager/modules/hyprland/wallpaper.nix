{pkgs, ...}: {
  home.packages = [
    pkgs.hyprpaper
  ];

  # TODO: Set this somewhere - config?
  home.file.".config/hypr/hyprpaper.conf".text = ''
    preload = ${../../../hosts/kirin/wallpaper.jpg}
    wallpaper = DP-1,${../../../hosts/kirin/wallpaper.jpg}
  '';
}
