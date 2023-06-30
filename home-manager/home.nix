{ inputs, lib, config, pkgs, ... }: {
  imports = [
    ./modules/zsh.nix
    ./modules/kitty.nix
    ./modules/fzf.nix
    ./modules/gnome.nix
    ./modules/steam.nix
    ./modules/nvim
    ./modules/git.nix
		./modules/3dp.nix
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = (_: true);

  programs.home-manager.enable = true;
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  xdg.enable = true;
  xdg.mime.enable = true;
  targets.genericLinux.enable = true;
  fonts.fontconfig.enable = true;

  home.username = "szymon";
  home.homeDirectory = "/home/szymon";
  home.stateVersion = "22.11";
  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
    TERMINAL = "kitty";
  };
  home.packages = [
    pkgs.firefox
    pkgs.bat
    pkgs.exa
    pkgs.ripgrep
    pkgs.fd
    pkgs.editorconfig-core-c
    pkgs.ffmpeg
    pkgs.obsidian
    pkgs.direnv
    pkgs.nix-direnv
    pkgs.unzip
    pkgs.usbutils
		pkgs.appimage-run

    # microcontrollers/electronics
    pkgs.temurin-jre-bin
    pkgs.kicad
    pkgs.lm_sensors
    pkgs.rpi-imager

    # emulators
    pkgs.flycast
    pkgs.mame
  ];
}
