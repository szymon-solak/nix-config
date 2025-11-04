{pkgs, ...}: {
  services.home-assistant = {
    enable = true;

    extraPackages = p: [
      p.psycopg2
      p.pysqueezebox
    ];

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
      "xiaomi_miio"
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
          "light.monitor_backlight"
        ];
        min_color_temp = 3700;
        max_color_temp = 5500;
        max_sunrise_time = "05:00:00";
        min_sunset_time = "23:30:00";
        # take_over_control = false;
        prefer_rgb_color = true;
        sleep_brightness = 1;
        sleep_rgb_color = [0 0 0];
        transition_until_sleep = false;
        sleep_transition = 60;
        sleep_color_temp = 2100;
      };

      schedule = {
        adaptive_lighting_sleep_mode = {
          name = "Adaptive Lighting Sleep Mode";
          monday = {
            from = "00:30";
            to = "08:00";
          };
          tuesday = {
            from = "00:30";
            to = "08:00";
          };
          wednesday = {
            from = "00:30";
            to = "08:00";
          };
          thursday = {
            from = "00:30";
            to = "08:00";
          };
          friday = {
            from = "00:30";
            to = "08:00";
          };
          saturday = {
            from = "00:30";
            to = "08:00";
          };
          sunday = {
            from = "00:30";
            to = "08:00";
          };
        };
      };

      "automation ui" = "!include automations.yaml";
      # "scene ui" = "!include scenes.yaml";
      # "script ui" = "!include scripts.yaml";

      "automation vacuum_around_litterboxe" = {
        alias = "Clean Litterboxes Automation";
        description = "";
        triggers = [
          {
            trigger = "state";
            entity_id = ["input_button.clean_litterboxes"];
          }
        ];
        conditions = [];
        actions = [
          {
            action = "vacuum.send_command";
            metadata = {};
            data = {
              command = "app_zoned_clean";
              params = [
                [
                  18200
                  25667
                  19465
                  26652
                  1
                ]
                [
                  23208
                  27306
                  24473
                  28290
                  1
                ]
              ];
            };
            target = {
              device_id = "ebe556e089c1d31f7aac9ccf6c9302fd";
            };
          }
        ];
        mode = "single";
      };

      "automation enable_sleep_mode" = {
        alias = "Enable Sleep Mode";
        description = "";
        triggers = [
          {
            trigger = "state";
            entity_id = ["schedule.adaptive_lighting_sleep_mode"];
            to = "on";
          }
        ];
        actions = [
          {
            service = "switch.turn_on";
            data = {
              entity_id = "switch.adaptive_lighting_sleep_mode_default";
            };
          }
        ];
      };

      "automation disabled_sleep_mode" = {
        alias = "Disable Sleep Mode";
        description = "";
        triggers = [
          {
            trigger = "state";
            entity_id = ["schedule.adaptive_lighting_sleep_mode"];
            to = "off";
          }
        ];
        actions = [
          {
            service = "switch.turn_off";
            data = {
              entity_id = "switch.adaptive_lighting_sleep_mode_default";
            };
          }
        ];
      };
    };

    customComponents = [
      pkgs.home-assistant-custom-components.adaptive_lighting
      (pkgs.callPackage ./components/roborock-custom-map.nix {})
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
