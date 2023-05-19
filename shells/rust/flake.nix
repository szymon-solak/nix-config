{
  description = "Rust devShell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, rust-overlay, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs { inherit system overlays; };
      in {
        devShells.default = pkgs.mkShell {
          name = "rust-env";

          buildInputs = [
            pkgs.openssl
            pkgs.pkg-config
            pkgs.rust-bin.stable.latest.default
            pkgs.rust-analyzer
          ];

          shellHook = "";
        };
      });
}
