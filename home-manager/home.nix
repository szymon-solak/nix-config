{pkgs, ...} @ inputs: {
  imports = [
    ./modules/base-utils.nix
    # ./modules/firefox.nix
    ./modules/zsh.nix
    ./modules/kitty.nix
    ./modules/gnome.nix
    ./modules/steam.nix
    ./modules/nvim
    ./modules/git.nix
    ./modules/3dp.nix
    ./modules/hyprland
  ];

  programs.home-manager.enable = true;
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  xdg.enable = true;
  xdg.mime.enable = true;
  targets.genericLinux.enable = true;

  home.stateVersion = "23.05";
  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
    TERMINAL = "kitty";
  };
  home.packages = [
    pkgs.firefox
    pkgs.obsidian
    pkgs.usbutils
    pkgs.appimage-run
    pkgs.amdgpu_top
    pkgs.via

    # microcontrollers/electronics
    pkgs.temurin-jre-bin
    pkgs.kicad
    pkgs.lm_sensors
    pkgs.rpi-imager
    pkgs.dfu-util
  ];
}
