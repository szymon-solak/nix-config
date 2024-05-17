{
  pkgs,
  pkgs-unstable,
  ...
}: let
in {
  home.packages = [
    pkgs-unstable.hyprshade
  ];

  home.file.".config/hypr/hyprshade.toml".text = ''
    [[shades]]
    name = "vibrance"
    default = true

    [[shades]]
    name = "blue-light-filter"
    start_time = 19:00:00
    end_time = 06:00:00
  '';
}
