{ config, pkgs, ... }: {
  imports = [
    ./modules/base-utils.nix
    ./modules/git.nix
    ./modules/zsh.nix
    ./modules/kitty.nix
    ./modules/nvim
    ./modules/darwin-application-activation.nix
  ];

  programs.home-manager.enable = true;
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = (_: true);

  home.username = "szymonsolak";
  home.homeDirectory = "/Users/szymonsolak";
  home.stateVersion = "23.05";
  home.packages = [
    pkgs.coreutils
    pkgs.gcc
    pkgs.python3
    pkgs.obsidian
    pkgs.lazydocker
    pkgs.awscli2
    pkgs.terraform
    pkgs.terragrunt
  ];
}
