{pkgs, ...}: {
  home.packages = [
    pkgs.easyeffects
  ];

  systemd.user.services.easyeffects = {
    Unit = {
      Description = "Easyeffects daemon";
      Requires = ["dbus.service"];
      After = ["graphical-session-pre.target"];
      PartOf = [
        "graphical-session.target"
        "pipewire.service"
      ];
    };

    Install = {
      WantedBy = ["graphical-session.target"];
    };

    Service = {
      ExecStart = "${pkgs.easyeffects}/bin/easyeffects --gapplication-service";
      ExecStop = "${pkgs.easyeffects}/bin/easyeffects --quit";
      Restart = "on-failure";
      RestartSec = 5;
    };
  };
}
