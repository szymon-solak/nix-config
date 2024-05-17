{pkgs-unstable, ...}: {
  programs.hyprland = {
    enable = true;
    package = pkgs-unstable.hyprland.override {
      # inherit (pkgs-unstable) mesa;
    };
    portalPackage = pkgs-unstable.xdg-desktop-portal-hyprland.override {
      # inherit (pkgs-unstable) mesa;
    };
  };
}
