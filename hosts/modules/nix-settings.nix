{
  lib,
  config,
  inputs,
  ...
}: {
  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };

    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
    '';

    gc = {
      automatic = true;
      # dates = "weekly";
      interval = {
        Weekday = 0;
        Hour = 0;
        Minute = 0;
      };
      options = "--delete-older-than 1w";
    };

    # Make nix3 commands consistent with flake
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
  };
}
