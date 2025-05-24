{
  pkgs,
  lib,
  ...
}: {
  home.packages = [
    pkgs.xwayland-satellite
  ];

  systemd.user.services.xwayland-satellite = {
    Install = {
      WantedBy = ["graphical-session.target"];
    };

    Unit = {
      Description = "Xwayland outside your Wayland";
      BindsTo = ["graphical-session.target"];
      PartOf = ["graphical-session.target"];
      After = ["graphical-session.target"];
      Requisite = ["graphical-session.target"];
    };

    Service = {
      Type = "notify";
      NotifyAccess = "all";
      StandardOutput = "journal";
      ExecStart = "${lib.getExe' pkgs.xwayland-satellite "xwayland-satellite"}";
    };
  };
}
