{pkgs, ...}: {
  home.packages = [
    pkgs.bluez
    pkgs.overskride
  ];

	stylix.targets.waybar.enable = false;

  programs.waybar = {
    enable = true;
    systemd.enable = true;
    systemd.target = "hyprland-session.target";

    style = ./waybar.css;

    settings = [
      {
        height = 34;
        margin = "0 8 10 8";
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
          "clock"
					"custom/power-button"
        ];

        "group/workspace" = {
          orientation = "inherit";
          modules = [
            "hyprland/window"
          ];
        };

        "group/center" = {
          orientation = "inherit";
          modules = [
            "hyprland/workspaces"
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
            "custom/gpu"
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
          # format = "{:%A, %d %B, %H:%M}";
          format = "{:%H:%M}";
        };

        bluetooth = {
          format = "󰂯";
          format-connected = "󰂱 ({num_connections})";
          tooltip-format = "{device_enumerate}";
          on-click = "overskride";
        };

        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            default = "";
            active = "";
          };
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
          format = "@ {temperatureC}°C";
          tooltip = false;
        };

        "custom/gpu" = {
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

				"custom/power-button" = {
					format = "";
					on-click = "wlogout --buttons-per-row=1";
					tooltip = false;
				};

        tray = {
          spacing = 6;
        };
      }
    ];
  };
}
