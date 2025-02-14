{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nur.modules.homeManager.default
    ./modules/base-utils.nix
    ./modules/firefox
    ./modules/zsh.nix
    ./modules/kitty.nix
    ./modules/nvim
    ./modules/git.nix
    ./modules/hyprland
    ./modules/android-studio.nix
    ./modules/orca-slicer.nix
    ./modules/zed.nix
  ];

  programs.home-manager.enable = true;
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  xdg.enable = true;
  xdg.mime.enable = true;
  targets.genericLinux.enable = true;

  home.stateVersion = "24.11";
  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
    TERMINAL = "kitty";
  };
  home.packages = [
    pkgs.obsidian
    pkgs.usbutils
    pkgs.appimage-run
    pkgs.amdgpu_top
    pkgs.via
    pkgs.vulkan-tools
    pkgs.pavucontrol
    pkgs.vlc
    pkgs.lm_sensors
    pkgs.rpi-imager
    pkgs.dfu-util
    pkgs.glxinfo
    pkgs.qbittorrent-nox
    pkgs.heroic
    pkgs.thunderbird
    pkgs.temurin-jre-bin
    pkgs.kicad
  ];
}
