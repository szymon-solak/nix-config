{ pkgs, ... }: {
  home.packages = [
    pkgs.hyprpaper
  ];

  home.file.".config/hypr/hyprpaper.conf".text = ''
			preload = ~/Pictures/wallpaper.jpg
			wallpaper = DP-1,~/Pictures/wallpaper.jpg
	'';
}
