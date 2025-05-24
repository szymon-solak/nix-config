{
  services.slimserver.enable = true;
  networking.firewall.allowedTCPPorts = [9000 9090 3483];
  networking.firewall.allowedUDPPorts = [3483];
}
