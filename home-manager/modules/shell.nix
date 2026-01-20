{pkgs, ...}: {
  home.packages = [
    pkgs.quickshell
    pkgs.noctalia-shell
  ];

  systemd.user.services.noctalia = {
    Unit = {
      Description = "Noctalia Shell Service";
      Requisite = ["graphical-session-pre.target"];
      After = ["graphical-session-pre.target"];
      PartOf = [
        "graphical-session.target"
      ];
    };

    Install = {
      WantedBy = ["graphical-session.target"];
    };

    Service = {
      ExecStart = "${pkgs.noctalia-shell}/bin/noctalia-shell";
      Restart = "on-failure";
      RestartSec = 1;
    };
  };
}
