{
  description = "Kotlin devShell";

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
        name = "kotlin";

        buildInputs = [
          pkgs.kotlin
          pkgs.kotlin-language-server
          pkgs.detekt
          pkgs.ktfmt
          pkgs.ktlint
          pkgs.gradle
        ];

        shellHook = "";
      };
    });
}
