{pkgs, ...}: let
  plymouth_themes = pkgs.adi1090x-plymouth-themes.override {
    selected_themes = ["hexagon_dots"];
  };
in {
  boot.plymouth = {
    enable = true;
    themePackages = [plymouth_themes];
    theme = "hexagon_dots";
  };
}
