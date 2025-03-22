{pkgs, ...}: {
  home.packages = [
    pkgs.wl-clipboard
    pkgs.cliphist
  ];

  services.cliphist = {
    enable = true;
    allowImages = true;
    systemdTarget = "hyprland-session.target";
  };
}
