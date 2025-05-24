{pkgs, ...}: {
  services.swayidle = {
    enable = false;
    timeouts = [
      {
        timeout = 900;
        command = "${pkgs.hyprlock}/bin/hyprlock";
      }
      {
        timeout = 1800;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
  };

  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      screenshots = true;
      clock = true;
      indicator = true;
      # indicator-idle-visible = false;
      effect-blur = "7x5";
      effect-vignette = "0.5:0.5";
      grace = 2;
      fade-in = 0.2;
    };
  };
}
