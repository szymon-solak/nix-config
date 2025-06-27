{
  description = "PlatformIO devShell";

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
        name = "pio";

        buildInputs = [
          pkgs.python3
          pkgs.arduino-cli
          pkgs.avrdude
          pkgs.platformio
          pkgs.esptool
        ];

        shellHook = "";
      };
    });
}
