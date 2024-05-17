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
  };

  boot.kernel.sysctl."vm.max_map_count" = 2147483642;
}
