{pkgs, ...}: {
  home.packages = [
    (pkgs.callPackage ./dmenu-bluetooth.nix {})
  ];

  home.sessionVariables = {
    DMENU_BLUETOOTH_LAUNCHER = "tofi";
  };

  programs.tofi = {
    enable = true;
    settings = {
      drun-launch = true;
      text-cursor = true;
      prompt-text = "can I have";
      prompt-padding = 10;
      border-width = 2;
      outline-width = 0;
      corner-radius = 10;
    };
  };
}
