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
    # ./modules/android-studio.nix
    ./modules/orca-slicer.nix
    ./modules/zed.nix
    ./modules/dmenu
    ./modules/wallpaper.nix
    ./modules/lock.nix
    ./modules/clipboard.nix
    ./modules/obs.nix
    ./modules/xwayland.nix
    ./modules/waybar.nix
    ./modules/wlogout.nix
  ];

  programs.home-manager.enable = true;
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  services.mako = {
    enable = true;
    settings.default-timeout = 5000;
  };

  services.udiskie = {
    enable = true;
    automount = true;
    notify = true;
    tray = "always";
  };

  xdg.enable = true;
  xdg.mime.enable = true;
  targets.genericLinux.enable = true;

  home.stateVersion = "24.11";
  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
    TERMINAL = "kitty";
  };

  gtk.enable = true;
  gtk.iconTheme = {
    package = pkgs.zafiro-icons;
    name = "zafiro-icons";
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
    pkgs.chromium
    pkgs.awscli2
    pkgs.nautilus
    pkgs.hyperhdr
    # pkgs.darkice
    pkgs.temurin-jre-bin
    pkgs.kicad
    pkgs.arduino-ide
  ];
}
