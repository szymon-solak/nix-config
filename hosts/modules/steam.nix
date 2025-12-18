{pkgs, ...}: {
  programs.steam = {
    enable = true;
    gamescopeSession = {
      enable = true;
      args = [
        "--adaptive-sync"
        "--hdr-enabled"
        "--hdr-itm-enable"
        "--mangoapp"
        "--rt"
      ];
    };
  };

  programs.gamescope = {
    enable = true;
    capSysNice = true;
    # args = [
    # "--adaptive-sync"
    # "--hdr-enabled"
    # "--hdr-itm-enable"
    # "--force-grab-cursor"
    # ];
  };

  programs.gamemode = {
    enable = true;
    enableRenice = true;
  };

  environment.systemPackages = [
    pkgs.mangohud
    pkgs.protonup-ng
  ];

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "home/user/.steam/root/compatibilitytoold.d";
    # MANGOHUD = 1;
    MANGOHUD_CONFIG = "cpu_temp,gpu_temp,gpu_power";
  };

  boot.kernel.sysctl."vm.max_map_count" = 2147483642;
}
