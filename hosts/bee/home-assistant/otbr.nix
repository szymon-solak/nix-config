{ config, ... }:
{
  services.openthread-border-router = {
    enable = true;
    backboneInterfaces = [ "wlo1" ];

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
}
