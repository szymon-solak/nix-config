{pkgs, ...}: {
  networking.firewall.allowedTCPPorts = [
    # config.services.home-assistant.config.http.server_port
    8123
  ];

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
      # "radio_browser"
      "shopping_list"
      # Recommended for fast zlib compression
      # https://www.home-assistant.io/integrations/isal
      "isal"

      "bluetooth"
      "usb"
      "homeassistant_connect_zbt2"

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

      adaptive_lighting = {
        name = "default";
        lights = [
          "light.kitchen_strip"
        ];
        min_color_temp = 3700;
        max_color_temp = 5500;
        max_sunrise_time = "05:00:00";
        min_sunset_time = "23:30:00";
      };

      schedule = {
        day_mode = {
          name = "Day Mode";
          monday = {
            from = "08:00";
            to = "23:30";
          };
          tuesday = {
            from = "08:00";
            to = "23:30";
          };
          wednesday = {
            from = "08:00";
            to = "23:30";
          };
          thursday = {
            from = "08:00";
            to = "23:30";
          };
          friday = {
            from = "08:00";
            to = "23:30";
          };
          saturday = {
            from = "08:00";
            to = "23:30";
          };
          sunday = {
            from = "08:00";
            to = "23:30";
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

      "automation enable_day_mode" = {
        alias = "Enable Day Mode";
        description = "";
        triggers = [
          {
            trigger = "state";
            entity_id = ["schedule.day_mode"];
            to = "on";
          }
        ];
        actions = [
          {
            service = "switch.turn_on";
            data = {
              entity_id = "switch.cuco_de_698951916_v2eur_on_p_2_1";
            };
          }
          {
            service = "light.turn_on";
            data = {
              entity_id = "light.kitchen_strip";
            };
          }
        ];
      };

      "automation disable_day_mode" = {
        alias = "Disable Day Mode";
        description = "";
        triggers = [
          {
            trigger = "state";
            entity_id = ["schedule.day_mode"];
            to = "off";
          }
        ];
        actions = [
          {
            service = "switch.turn_off";
            data = {
              entity_id = "switch.cuco_de_698951916_v2eur_on_p_2_1";
            };
          }
          {
            service = "light.turn_off";
            data = {
              entity_id = "light.kitchen_strip";
            };
          }
        ];
      };
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
