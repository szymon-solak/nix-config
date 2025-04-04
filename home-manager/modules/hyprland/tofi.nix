{
  pkgs,
  lib,
  ...
}: {
  home.packages = [
    (pkgs.callPackage ./dmenu-bluetooth.nix {})
  ];

  home.sessionVariables = {
    DMENU_BLUETOOTH_LAUNCHER = "tofi";
  };

  # https://github.com/NixOS/nixpkgs/issues/336432
  home.activation.clearTofiCache = lib.hm.dag.entryAfter ["writeBoundary"] ''
    $DRY_RUN_CMD rm -rf ~/.cache/tofi-drun
  '';

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
