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
	disabledModules = [ "targets/darwin/linkapps.nix" ];
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = (_: true);

  home.username = "szymonsolak";
  home.homeDirectory = "/Users/szymonsolak";
  home.stateVersion = "22.11";
  home.packages = [
    pkgs.coreutils
    pkgs.gcc
    pkgs.python3

		pkgs.obsidian
    pkgs.lazydocker
    pkgs.awscli2
  ];
}
