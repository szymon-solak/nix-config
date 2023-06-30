{
  description = "JS devShell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = { allowUnfree = true; };
        };

      in {
        devShells.default = pkgs.mkShell {
          name = "node-env";

          buildInputs = [
            pkgs.gnupg
            pkgs.asdf-vm
            pkgs.nodePackages.jsonlint
            pkgs.nodePackages.eslint
            pkgs.nodePackages.typescript
            pkgs.nodePackages.typescript-language-server
            pkgs.nodePackages.vscode-langservers-extracted
          ];

          shellHook =
            "	export ASDF_NODEJS_LEGACY_FILE_DYNAMIC_STRATEGY=latest_available\n	export PATH=$HOME/.asdf/shims:$PATH\n\n	if [[ ! -e $HOME/.asdfrc ]]; then\n		echo \"legacy_version_file = yes\" > $HOME/.asdfrc\n	fi\n\n	if [[ ! -e ./.nvmrc ]]; then\n		echo \"20\" >> .nvmrc\n	fi\n";
        };
      });
}
