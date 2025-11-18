{
  lib,
  pkgs,
  inputs,
  ...
}: let
  linux-firefox = pkgs.wrapFirefox (pkgs.firefox-unwrapped.override {
    pipewireSupport = true;
  }) {};

  macos-firefox = pkgs.callPackage ./pkgs/firefox.nix {};

  unstable = import inputs.nixpkgs-unstable {
    system = "x86_64-linux";
    config = {
      allowUnfreePredicate = pkg:
        builtins.elem (lib.getName pkg) [
          "copilot-language-server"
        ];
    };
  };
in {
  nixpkgs.overlays = [
    (final: prev: {
      firefox =
        if pkgs.stdenv.isDarwin
        then macos-firefox
        else linux-firefox;

      # pipewire = unstable.pipewire;
      vimPlugins = unstable.vimPlugins;

      lact = unstable.lact;
    })
  ];
}
