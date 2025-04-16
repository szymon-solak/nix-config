{pkgs, ...}: {
  imports = [
    ./tofi.nix
    ./fuzzel.nix
  ];

  home.sessionVariables = {
    DMENU_BLUETOOTH_LAUNCHER = "fuzzel";
  };

  home.packages = [
    (pkgs.callPackage ./dmenu-bluetooth.nix {})
  ];
}
