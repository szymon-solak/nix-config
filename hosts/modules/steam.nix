{pkgs, ...}: {
  programs.steam = {
    enable = true;
    gamescopeSession = {
      enable = true;
      args = [
        "--expose-wayland"
        "-f"
        "--steam"
        "--adaptive-sync"
        "--hdr-enabled"
        "--hdr-itm-enable"
      ];
    };
  };

  programs.gamescope = {
    enable = true;
    capSysNice = true;
    args = [
      "--adaptive-sync"
      "--hdr-enabled"
      "--hdr-itm-enable"
    ];
  };

  programs.gamemode = {
    enable = true;
    enableRenice = true;
  };

  environment.systemPackages = [
    pkgs.mangohud
    pkgs.protonup
  ];

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "home/user/.steam/root/compatibilitytoold.d";
    MANGOHUD_CONFIG = "cpu_temp,gpu_temp";
  };

  boot.kernel.sysctl."vm.max_map_count" = 2147483642;
}
