{
  pkgs,
  config,
  ...
}: let
  chip-ota-provider = pkgs.callPackage ../matter/chip-ota-provider.nix {};
in {
  # imports = [
  #   ./openthread-border-router.nix
  # ];

  services.openthread-border-router = {
    enable = true;
    # package = pkgs.callPackage ./package.nix {};
    backboneInterfaces = ["wlo1"];

    radio = {
      device = "/dev/serial/by-id/usb-Nabu_Casa_ZBT-2_E072A1FB8288-if00";
      baudRate = 460800;
      flowControl = true;
    };

    rest = {
      listenAddress = "::";
    };

    web = {
      enable = true;
      listenAddress = "::";
    };
  };

  networking.firewall.allowedTCPPorts = [
    config.services.openthread-border-router.rest.listenPort
    config.services.openthread-border-router.web.listenPort
  ];

  services.matter-server = {
    enable = true;
    openFirewall = true;
    package = pkgs.python-matter-server.overrideAttrs (oldAttributes: {
      nativeBuildInputs =
        oldAttributes.nativeBuildInputs
        ++ [
          pkgs.makeWrapper
        ];

      buildInputs =
        (oldAttributes.buildInputs or [])
        ++ [
          chip-ota-provider
        ];

      postFixup =
        oldAttributes.postFixup
        + ''
          wrapProgram $out/bin/matter-server --prefix PATH : ${pkgs.lib.makeBinPath [chip-ota-provider]}
        '';
    });
  };
}
