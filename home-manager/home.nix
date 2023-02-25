{ inputs, lib, config, pkgs, ... }: {
  imports = [ ./modules/zsh.nix ./modules/kitty.nix ./modules/fzf.nix ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = (_: true);

  programs.home-manager.enable = true;

  xdg.enable = true;
  xdg.mime.enable = true;
  targets.genericLinux.enable = true;

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
    pkgs.kitty
    pkgs.bat
    pkgs.exa
    pkgs.ripgrep
    pkgs.fzf
    pkgs.fd
    pkgs.editorconfig-core-c
    pkgs.ffmpeg
    pkgs.obsidian
    pkgs.nerdfonts
    pkgs.gnomeExtensions.pop-shell
    pkgs.gnomeExtensions.pop-launcher-super-key
    pkgs.neovim
    pkgs.vimPlugins.packer-nvim
  ];
}
