{
  description = "nix-config devShell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {inherit system;};
      in {
        devShells.default =
          pkgs.mkShell {
            name = "nix-config";

            buildInputs = [
              pkgs.lua
              pkgs.luajit
              pkgs.lua-language-server
              pkgs.nil
              pkgs.just
            ];

            shellHook = "
							export NIL_LS_PATH=${pkgs.nil}/bin/nil
					";
          };
      }
    );
}
