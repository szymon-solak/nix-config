{
  description = "Lua devShell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };

      in {
        devShells.default = pkgs.mkShell {
          name = "lua";

          buildInputs =
            [ pkgs.lua pkgs.luajit pkgs.sumneko-lua-language-server ];

          shellHook = "";
        };
      });
}
