{pkgs, ...}: let
  linux-firefox = pkgs.wrapFirefox (pkgs.firefox-unwrapped.override {
    pipewireSupport = true;
  }) {};

  macos-firefox = pkgs.callPackage ./pkgs/firefox.nix {};
in {
  nixpkgs.overlays = [
    (final: prev: {
      firefox =
        if pkgs.stdenv.isDarwin
        then macos-firefox
        else linux-firefox;
    })
  ];
}
