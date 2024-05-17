{
  description = "Elixir dev shell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system;};
      otp = pkgs.beam.packages.erlangR26;
    in {
      devShells.default = pkgs.mkShell {
        name = "elixir";

        buildInputs =
          [
            otp.elixir_1_16
            pkgs.elixir-ls
            pkgs.nil
            pkgs.nodePackages.jsonlint
            pkgs.nodePackages.eslint
            pkgs.nodePackages.eslint_d
            pkgs.nodePackages.typescript
            pkgs.nodePackages.typescript-language-server
            pkgs.nodePackages.vscode-langservers-extracted
          ]
          ++ pkgs.lib.optionals pkgs.stdenv.isLinux [
            pkgs.inotify-tools
          ]
          ++ pkgs.lib.optionals pkgs.stdenv.isDarwin [
            pkgs.darwin.apple_sdk.frameworks.CoreFoundation
            pkgs.darwin.apple_sdk.frameworks.CoreServices
          ];

        shellHook = ''
          mkdir -p .nix-mix .nix-hex
          export MIX_HOME=$PWD/.nix-mix
          export HEX_HOME=$PWD/.nix-hex

          # make hex from Nixpkgs available
          # `mix local.hex` will install hex into MIX_HOME and should take precedence
          export MIX_PATH="${otp.hex}/lib/erlang/lib/hex/ebin"
          export PATH=$MIX_HOME/bin:$HEX_HOME/bin:$PATH

          # enables history for IEx
          export ERL_AFLAGS="-kernel shell_history enabled -kernel shell_history_path '\"$PWD/.erlang-history\"'"

          export ELIXIR_LS_PATH=${pkgs.elixir-ls}/bin/elixir-ls
          export NIL_LS_PATH=${pkgs.nil}/bin/nil
        '';
      };
    });
}
