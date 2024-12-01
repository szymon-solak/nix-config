{
  description = "Python devShell with Poetry";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system;};
    in {
      devShells.default = pkgs.mkShell {
        name = "python";

        buildInputs = [
          pkgs.python314
          pkgs.poetry
          pkgs.ruff
          pkgs.ruff-lsp
        ];

        shellHook = ''
        '';
      };
    });
}
