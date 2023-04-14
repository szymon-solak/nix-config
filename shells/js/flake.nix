{
  description = "JS devShell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = { allowUnfree = true; };
        };

      in {
        devShells.default = pkgs.mkShell {
          name = "node-env";

          buildInputs = [ pkgs.fnm pkgs.steam-run pkgs.nodePackages.jsonlint ];

          shellHook =
            "	if [[ ! -e ./.nvmrc ]]; then\n		echo \\\"18\\\" >> .nvmrc\n	fi\n	alias node=\"steam-run node\"\n	alias npm=\"steam-run npm\"\n\n	eval \"$(fnm env --use-on-cd)\"\n	fnm use\n";
        };
      });
}
