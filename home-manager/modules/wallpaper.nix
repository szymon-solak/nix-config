{
  pkgs,
  lib,
  ...
}: {
  home.packages = [
    pkgs.swww
  ];

  systemd.user.services.swww = {
    Install = {
      WantedBy = ["graphical-session.target"];
    };

    Unit = {
      ConditionEnvironment = "WAYLAND_DISPLAY";
      Description = "swww-daemon";
      After = ["graphical-session.target"];
      PartOf = ["graphical-session.target"];
    };

    Service = {
      ExecStart = "${lib.getExe' pkgs.swww "swww-daemon"}";
      Restart = "always";
      RestartSec = 10;
    };
  };
}
