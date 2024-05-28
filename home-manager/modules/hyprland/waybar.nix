{pkgs, ...}: {
  home.packages = [
    pkgs.bluez
    pkgs.overskride
  ];

  programs.waybar = {
    enable = true;
    systemd.enable = true;
    systemd.target = "hyprland-session.target";

    style = ''
        @define-color red #f38ba8;
        @define-color blue #89b4fa;
        @define-color lavender #b4befe;

        window#waybar {
        	background-color: transparent;
        }

        #workspace {
        	padding-left: 0.625em;
        	padding-right: 0.625em;
        }

        #workspaces button {
        	border-radius: 0;
        }

        #workspaces button.active {
        	border-bottom: 1px solid @lavender;
        }

        #workspaces button.urgent {
        	color: @red;
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
        	padding-left: 0.625em;
        	padding-right: 0.625em;
        }

        #bluetooth.on, #bluetooth.connected {
        	background-color: @blue;
      color: #1f1f1f;
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
          format = "@ {temperatureC}°C";
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
          format = "@ {temperatureC}°C";
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
