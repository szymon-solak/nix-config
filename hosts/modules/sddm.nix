{pkgs, ...}: let
  sddm-sugar-candy = pkgs.libsForQt5.callPackage ./sddm-sugar-candy.nix {};
in {
  environment.systemPackages = [
    (sddm-sugar-candy.override {
      themeConfig.General = {
        Background = "${./login_bg.jpg}";
        ScreenWidth = "3440";
        ScreenHeight = "1440";
        FormPosition = "center";
        Locale = "en_US.UTF-8";
      };
    })
  ];

  services.xserver = {
    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
        theme = "sugar-candy";
      };
    };
  };
}
