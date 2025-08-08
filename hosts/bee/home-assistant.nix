{pkgs, ...}: {
  services.home-assistant = {
    enable = true;

    extraPackages = p: [p.psycopg2];

    extraComponents = [
      # Components required to complete the onboarding
      "analytics"
      "google_translate"
      "met"
      "radio_browser"
      "shopping_list"
      # Recommended for fast zlib compression
      # https://www.home-assistant.io/integrations/isal
      "isal"

      "yeelight"
      "wled"
      "roborock"
    ];

    config = {
      # Includes dependencies for a basic setup
      # https://www.home-assistant.io/integrations/default_config/
      default_config = {};

      recorder.db_url = "postgresql://@/hass";

      http = {
        server_host = "127.0.0.1";
        trusted_proxies = [
          "127.0.0.1"
          "::1"
        ];
        use_x_forwarded_for = true;
      };

      adaptive_lighting = {
        name = "default";
        lights = [
          "light.kitchen_strip"
        ];
        prefer_rgb_color = true;
      };
    };

    customComponents = [
      pkgs.home-assistant-custom-components.adaptive_lighting
      (pkgs.callPackage ./roborock-custom-map.nix {})
    ];

    customLovelaceModules = [
      (pkgs.callPackage ./lovelace-vacuum-mop-card.nix {})
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
