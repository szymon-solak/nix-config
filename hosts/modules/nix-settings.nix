{
  lib,
  config,
  inputs,
  ...
}: {
  nix = {
    optimise.automatic = true;

    settings = {
      experimental-features = "nix-command flakes";
    };

    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
    '';

    # Make nix3 commands consistent with flake
    # registry = lib.mapAttrs (_: value: {flake = value;}) inputs;
    # nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
  };
}
