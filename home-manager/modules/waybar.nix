{pkgs, ...}: {
  home.packages = [
    pkgs.bluez
    pkgs.overskride
    pkgs.pavucontrol
    pkgs.helvum
  ];

  stylix.targets.waybar.enable = false;

  programs.waybar = {
    enable = true;
    systemd.enable = true;
    systemd.target = "graphical-session.target";

    style = ./waybar.css;

    settings = [
      {
        height = 34;
        margin = "0 8 10 8";
        layer = "top";
        position = "bottom";
        spacing = 0;

        # TODO: Warning states for high usage?
        modules-left = ["group/workspace"];
        modules-center = ["group/center"];
        modules-right = [
          "group/cpu-usage"
          "group/gpu-usage"
          "group/memory-usage"
          "group/bt"
          "group/audio"
          "group/net"
          "tray"
          "group/time"
          "custom/power-button"
        ];

        "group/time" = {
          orientation = "inherit";
          modules = [
            "custom/clock-icon"
            "clock"
          ];
        };

        "group/net" = {
          orientation = "inherit";
          modules = [
            "custom/network-icon"
            "network"
          ];
        };

        "group/bt" = {
          orientation = "inherit";
          modules = [
            "custom/bluetooth-icon"
            "bluetooth"
          ];
        };

        "group/workspace" = {
          orientation = "inherit";
          modules = [
            "custom/workspace-icon"
            "hyprland/window"
            "niri/window"
          ];
        };

        "group/center" = {
          orientation = "inherit";
          modules = [
            "hyprland/workspaces"
            "niri/workspaces"
          ];
        };

        "group/cpu-usage" = {
          orientation = "inherit";
          modules = [
            "custom/cpu-icon"
            "cpu"
            "temperature#cpu"
          ];
        };

        "group/gpu-usage" = {
          orientation = "inherit";
          modules = [
            "custom/gpu-icon"
            "custom/gpu"
            "temperature#gpu"
          ];
        };

        "group/memory-usage" = {
          orientation = "inherit";
          modules = [
            "custom/memory-icon"
            "memory"
          ];
        };

        "group/audio" = {
          orientation = "inherit";
          modules = [
            "custom/audio-icon"
            "wireplumber"
          ];
        };

        "custom/clock-icon" = {
          format = "";
          tooltip = false;
        };

        clock = {
          # format = "{:%A, %d %B, %H:%M}";
          format = "{:%H:%M}";
        };

        "custom/bluetooth-icon" = {
          format = "󰂯";
          tooltip = false;
        };

        bluetooth = {
          format = "{status}";
          format-connected = "{status} ({num_connections})";
          tooltip-format = "{device_enumerate}";
          on-click = "overskride";
        };

        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            default = "";
            active = "";
          };
          # persistent-workspaces = {
          #   "*" = 4;
          # };
        };

        "niri/workspaces" = {
          format = "{icon}";
          format-icons = {
            default = "";
            active = "";
          };
        };

        "custom/workspace-icon" = {
          format = "";
          tooltip = false;
        };

        "hyprland/window" = {
          format = "{}";
          separate-outputs = true;
        };

        "niri/window" = {
          separate-outputs = true;
        };

        "custom/cpu-icon" = {
          format = "CPU";
          tooltip = false;
        };

        cpu = {
          format = "{usage:2}%";
        };

        "temperature#cpu" = {
          hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
          format = "@ {temperatureC}°C";
          tooltip = false;
        };

        "custom/gpu-icon" = {
          format = "GPU";
          tooltip = false;
        };

        "custom/gpu" = {
          exec = "cat /sys/class/hwmon/hwmon0/device/gpu_busy_percent";
          format = " {}%";
          return-type = "";
          interval = 10;
          tooltip = false;
        };

        "temperature#gpu" = {
          hwmon-path = "/sys/class/hwmon/hwmon0/temp1_input";
          format = " @ {temperatureC}°C";
          tooltip = false;
        };

        "custom/memory-icon" = {
          # format = "";
          format = "MEM";
          tooltip = false;
        };

        memory = {
          interval = 30;
          format = "{used:0.1f}G/{total:0.1f}G";
          tooltip = false;
        };

        # TODO: Format different for wired vs wireless
        "custom/network-icon" = {
          format = "󰖩";
          tooltip = false;
        };

        network = {
          format = "{ifname}";
          foramt-wifi = "󰖩 {essid} ({signalStrength}%)";
          format-ethernet = "{ipaddr}";
          format-disconnected = "Offline";
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

        "custom/audio-icon" = {
          format = "󰎉";
          tooltip = false;
        };

        wireplumber = {
          format = "{icon}  {volume}%";
          format-muted = "";
          on-click = "pavucontrol";
          on-click-right = "helvum";
          format-icons = ["" "" ""];
        };
      }
    ];
  };
}
