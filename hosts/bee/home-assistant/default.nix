{pkgs, ...}: {
  imports = [
    ./automations/dual-button-remote.nix
    ./automations/scroll-remote.nix
    ./automations/vacuum.nix
    ./automations/day-and-night.nix
    ./automations/light-timer.nix
    ./groups/lights.nix
    ./groups/audio.nix
    ./scenes/day.nix
    ./scenes/evening.nix
    ./scenes/night.nix
    ./templates/temperature-forecast.nix
    ./integrations/adaptive-lighting.nix
  ];

  services.home-assistant = {
    enable = true;
    openFirewall = true;

    extraPackages = p: [
      p.psycopg2
      p.pysqueezebox
    ];

    extraComponents = [
      # Components required to complete the onboarding
      "analytics"
      "google_translate"
      "met"
      # "radio_browser"
      "shopping_list"
      # Recommended for fast zlib compression
      # https://www.home-assistant.io/integrations/isal
      "isal"

      "bluetooth"
      "usb"
      "matter"
      "thread"
      "otbr"

      "yeelight"
      "wled"
      "roborock"
      "xiaomi_miio"
      "ffmpeg"
      "zeroconf"
    ];

    config = {
      # Includes dependencies for a basic setup
      # https://www.home-assistant.io/integrations/default_config/
      default_config = {};

      recorder.db_url = "postgresql://@/hass";

      http = {
        # server_host = "127.0.0.1";
        trusted_proxies = [
          "127.0.0.1"
          "::1"
        ];
        use_x_forwarded_for = true;
      };

      "automation ui" = "!include automations.yaml";
      # "scene ui" = "!include scenes.yaml";
      # "script ui" = "!include scripts.yaml";
    };

    customComponents = [
      pkgs.home-assistant-custom-components.adaptive_lighting
      (pkgs.callPackage ./components/roborock-custom-map.nix {})
      pkgs.home-assistant-custom-components.xiaomi_home
    ];

    customLovelaceModules = [
      pkgs.home-assistant-custom-lovelace-modules.hourly-weather
      (pkgs.callPackage ./lovelace-modules/lovelace-vacuum-mop-card.nix {})
      (pkgs.callPackage ./lovelace-modules/lovelace-horizon-card.nix {})
    ];
  };

  services.postgresql = {
    enable = true;
    ensureDatabases = ["hass"];
    ensureUsers = [
      {
        name = "hass";
        ensureDBOwnership = true;
      }
    ];
  };
}
