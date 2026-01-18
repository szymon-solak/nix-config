{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nur.modules.homeManager.default
    ./modules/base-utils.nix
    ./modules/firefox
    ./modules/git.nix
    ./modules/zsh.nix
    ./modules/kitty.nix
    ./modules/nvim
    # ./modules/darwin-application-activation.nix
    ./modules/zed.nix
  ];

  programs.home-manager.enable = true;
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  home.stateVersion = "24.11";
  home.packages = [
    pkgs.coreutils
    pkgs.gcc
    pkgs.python3
    pkgs.obsidian
    pkgs.lazydocker
    pkgs.awscli2
    # pkgs.terraform
    # pkgs.terragrunt
    # pkgs.tart
    # pkgs.ollama
    pkgs.google-cloud-sdk
		# pkgs.ngrok
  ];
}
