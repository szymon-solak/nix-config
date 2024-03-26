{
  description = "Node 18.x JS devShell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        # jsDebug = pkgs.stdenv.mkDerivation {
        # 	name = "vscode-js-debug";
        # 	version = "1.78.0";
        # 	src = ./js-nix;
        #
        # 	postBuild = ''
        # 		mkdir -p $out/out
        # 		ls
        # 	'';
        # };
      in {
        devShells.default = pkgs.mkShell {
          name = "node";

          buildInputs = [
            pkgs.nodejs-18_x
            pkgs.nodePackages.jsonlint
            pkgs.nodePackages.eslint
            pkgs.nodePackages.typescript
            pkgs.nodePackages.typescript-language-server
            pkgs.nodePackages.vscode-langservers-extracted
          ];

          # shellHook = "
          # 	export NODE_PATH=${pkgs.nodejs-18_x}/bin/node
          # 	export VSCODE_JS_DEBUG_PATH=${jsDebug}
          # ";
        };
      });
}
