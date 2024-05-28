{
  description = "Rust devShell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    fenix,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
        overlays = [fenix.overlays.default];
        pkgs = import nixpkgs {inherit system overlays;};
      in {
        devShells.default =
          pkgs.mkShell {
            name = "rust";

            buildInputs = [
              (fenix.packages.${system}.stable.withComponents [
                "cargo"
                "clippy"
                "rust-src"
                "rustc"
                "rustfmt"
              ])
              pkgs.nil
              pkgs.rust-analyzer
            ];

            shellHook = "
							export NIL_LS_PATH=${pkgs.nil}/bin/nil
							export PATH=$HOME/.cargo/bin:$PATH
					";
          };
      });
}
