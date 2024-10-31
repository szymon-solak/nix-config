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
							pkgs.iconv
            ] ++ pkgs.lib.optionals pkgs.stdenv.isDarwin [
							pkgs.darwin.apple_sdk.frameworks.CoreFoundation
							pkgs.darwin.apple_sdk.frameworks.CoreServices
							pkgs.darwin.apple_sdk.frameworks.CoreGraphics
							pkgs.darwin.apple_sdk.frameworks.CoreVideo
							pkgs.darwin.apple_sdk.frameworks.ApplicationServices
							pkgs.darwin.apple_sdk.frameworks.Carbon
							pkgs.darwin.apple_sdk.frameworks.AppKit
						];

            shellHook = "
							export NIL_LS_PATH=${pkgs.nil}/bin/nil
							export PATH=$HOME/.cargo/bin:$PATH
					";
          };
      });
}
