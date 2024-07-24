{
  description = "JS devShell";

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
        name = "node";

        buildInputs = [
          pkgs.gnupg
          pkgs.asdf-vm
          pkgs.nodePackages.jsonlint
          pkgs.nodePackages.eslint
          pkgs.nodePackages.eslint_d
          pkgs.nodePackages.typescript
          pkgs.nodePackages.typescript-language-server
          pkgs.nodePackages.vscode-langservers-extracted
					pkgs.biome
        ];

        shellHook = ''
          export ASDF_NODEJS_LEGACY_FILE_DYNAMIC_STRATEGY=latest_available
          export PATH=$HOME/.asdf/shims:$PATH
          export ESLINT_USE_FLAT_CONFIG=true

          if [[ ! -e $HOME/.asdfrc ]]; then
          	echo \"legacy_version_file = yes\" > $HOME/.asdfrc
          fi

          if [[ ! -e ./.nvmrc ]]; then
          	echo \"20\" >> .nvmrc
          fi
        '';
      };
    });
}
