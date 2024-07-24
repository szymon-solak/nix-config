{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.lact
  ];

  systemd.services.lactd = {
    description = "AMDGPU Control Daemon";
    wantedBy = ["multi-user.target"];
    after = ["multi-user.target"];
    serviceConfig = {
      ExecStart = "${pkgs.lact}/bin/lact daemon";
      Nice = -10;
    };
  };
}
