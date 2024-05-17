{
  pkgs,
  pkgs-unstable,
  ...
}: {
  home.packages = [
    pkgs.waybar
    pkgs.bluez
    pkgs-unstable.overskride
  ];

  programs.waybar = {
    enable = true;

    style = ''
      /* Catppuccin Mocha */
      @define-color rosewater #f5e0dc;
      @define-color flamingo #f2cdcd;
      @define-color pink #f5c2e7;
      @define-color mauve #cba6f7;
      @define-color red #f38ba8;
      @define-color maroon #eba0ac;
      @define-color peach #fab387;
      @define-color yellow #f9e2af;
      @define-color green #a6e3a1;
      @define-color teal #94e2d5;
      @define-color sky #89dceb;
      @define-color sapphire #74c7ec;
      @define-color blue #89b4fa;
      @define-color lavender #b4befe;
      @define-color text #cdd6f4;
      @define-color subtext1 #bac2de;
      @define-color subtext0 #a6adc8;
      @define-color overlay2 #9399b2;
      @define-color overlay1 #7f849c;
      @define-color overlay0 #6c7086;
      @define-color surface2 #585b70;
      @define-color surface1 #45475a;
      @define-color surface0 #313244;
      @define-color base #1e1e2e;
      @define-color mantle #181825;
      @define-color crust #11111b;

      * {
      	font-family: 'Iosevka Nerd Font';
      }

      window#waybar {
      	background-color: transparent;
      }

      #workspace {
      	background-color: @mantle;
      	border-radius: 0.375em;
      	padding-left: 0.625em;
      	padding-right: 0.625em;
      }

      #workspaces button {
      	border-radius: 0;
      	color: @overlay0;
      }

      #workspaces button.active {
      	color: @lavender;
      	border-bottom: 1px solid @lavender;
      }

      #workspaces button.urgent {
      	color: @red;
      }

      #window {
      	color: @text;
      }

      window#waybar.empty #window {
      	font-size: 0;
      	padding: 0;
      	margin: 0;
      }

      #center,
      #cpu-usage,
      #gpu-usage,
      #memory-usage,
      #bluetooth,
      #network
      {
      	background-color: @mantle;
      	color: @text;
      	border-radius: 0.375em;
      	padding-left: 0.625em;
      	padding-right: 0.625em;
      	margin-right: 0.625em;
      }

      #bluetooth.on, #bluetooth.connected {
      	background-color: @blue;
      	color: @mantle;
      }
    '';

    settings = [
      {
        margin = "0 20 6 20";
        layer = "top";
        position = "bottom";
        spacing = 0;

        # TODO: Volume widget?
        # TODO: Warning states for high usage?
        modules-left = ["group/workspace"];
        modules-center = ["group/center"];
        modules-right = [
          "group/cpu-usage"
          "group/gpu-usage"
          "group/memory-usage"
          "bluetooth"
          "network"
          "tray"
        ];

        "group/workspace" = {
          orientation = "inherit";
          modules = [
            "hyprland/workspaces"
            "hyprland/window"
          ];
        };

        "group/center" = {
          orientation = "inherit";
          modules = [
            "clock"
          ];
        };

        "group/cpu-usage" = {
          orientation = "inherit";
          modules = [
            "cpu"
            "temperature#cpu"
          ];
        };

        "group/gpu-usage" = {
          orientation = "inherit";
          modules = [
            "custom/gpu-usage"
            "temperature#gpu"
          ];
        };

        "group/memory-usage" = {
          orientation = "inherit";
          modules = [
            "memory"
          ];
        };

        clock = {
          format = "{:%A, %d %B, %H:%M}";
        };

        bluetooth = {
          format = "󰂯";
          format-connected = "󰂱 ({num_connections})";
          tooltip-format = "{device_enumerate}";
          on-click = "overskride";
        };

        "hyprland/workspaces" = {
          persistent-workspaces = {
            "*" = 4;
          };
        };

        "hyprland/window" = {
          format = " {}";
          separate-outputs = true;
        };

        cpu = {
          format = "CPU: {usage:2}%";
        };

        "temperature#cpu" = {
          hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
          format = " @ {temperatureC}°C";
          tooltip = false;
        };

        "custom/gpu-usage" = {
          exec = "cat /sys/class/hwmon/hwmon0/device/gpu_busy_percent";
          format = "GPU: {}%";
          return-type = "";
          interval = 10;
          tooltip = false;
        };

        "temperature#gpu" = {
          hwmon-path = "/sys/class/hwmon/hwmon0/temp1_input";
          format = " @ {temperatureC}°C";
          tooltip = false;
        };

        memory = {
          interval = 30;
          format = "{used:0.1f}G/{total:0.1f}G";
          tooltip = false;
        };

        network = {
          format = "{ifname}";
          foramt-wifi = "󰖩 {essid} ({signalStrength}%)";
          format-ethernet = "󰈁 {ipaddr}";
          format-disconnected = "󰈂 Offline";
          tooltip-format = "{ifname} via {gwaddr}";
        };
      }
    ];
  };
}
