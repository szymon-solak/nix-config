{
  description = "Node 16.x JS devShell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = { permittedInsecurePackages = [ "nodejs-16.20.0" ]; };
        };
      in {
        devShells.default = pkgs.mkShell {
          name = "node";

          buildInputs = [
            pkgs.nodejs-16_x
            pkgs.nodePackages.jsonlint
            pkgs.nodePackages.eslint
            pkgs.nodePackages.typescript
            pkgs.nodePackages.typescript-language-server
            pkgs.nodePackages.vscode-langservers-extracted
          ];
        };
      });
}
