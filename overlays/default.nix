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
          "XiaoMi/xiaomi_home"
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

      vimPlugins = unstable.vimPlugins;
      lact = unstable.lact;
      noctalia-shell = unstable.noctalia-shell;
      winetricks = unstable.winetricks;

      home-assistant = unstable.home-assistant;
      home-assistant-custom-components = unstable.home-assistant-custom-components;
      home-assistant-custom-lovelace-modules = unstable.home-assistant-custom-lovelace-modules;
    })
  ];
}
