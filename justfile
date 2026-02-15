hostname := `hostname`

format:
	nix fmt ./**/*.nix

rebuild flake=hostname:
	just rebuild_{{os()}} {{flake}}

rebuild_linux flake=hostname:
	nixos-rebuild switch --flake .#{{flake}} --sudo
	# nixos-rebuild switch --flake .#{{flake}} --sudo |& nom

rebuild_macos flake=hostname:
	sudo darwin-rebuild switch --flake .#{{flake}}

rebuild_remote target_host flake:
	NIX_SSHOPTS="-tt" nixos-rebuild switch --target-host {{target_host}} --flake .#{{flake}} --sudo
