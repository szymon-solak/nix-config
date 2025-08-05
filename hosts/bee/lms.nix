{pkgs, ...}: {
  services.slimserver.enable = true;

  networking.firewall.allowedTCPPorts = [9000 9090 3483];
  networking.firewall.allowedUDPPorts = [3483];

  systemd.timers."restart-lms" = {
    wantedBy = ["timers.target"];
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
      Unit = "restart-lms.service";
    };
  };

  systemd.services."restart-lms" = {
    script = ''
      set -eu
      ${pkgs.systemd}/bin/systemctl restart slimserver
    '';

    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
  };
}
