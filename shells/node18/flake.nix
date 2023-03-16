{
  description = "Node 18.x JS devShell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };

      in {
        devShells.default = pkgs.mkShell {
          name = "node-env";

          buildInputs = [ pkgs.nodejs-18_x pkgs.nodePackages.jsonlint ];

          shellHook = "";
        };
      });
}
