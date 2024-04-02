{ pkgs, ... }: {
	home.packages = [
		pkgs.waybar
	];

	programs.waybar = {
		enable = true;
		systemd.enable = true;

		# icon before window title
		# active workspace
		# bt/wifi formatting
		# usage islands/groups
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
				font-family: 'Iosevka Nerd Font Mono';
				color: @text;
			}

			window#waybar {
				background-color: transparent;
			}

			#center {
				background-color: @mantle;
				border-radius: 6px;
				padding-left: 16px;
				padding-right: 16px;
			}

			#cpu-usage {
				background-color: @mantle;
				border-radius: 6px;
				padding-left: 10px;
				padding-right: 10px;
				margin-right: 10px;
			}

			#gpu-usage {
				background-color: @mantle;
				border-radius: 6px;
				padding-left: 10px;
				padding-right: 10px;
				margin-right: 10px;
			}

			#memory-usage {
				background-color: @mantle;
				border-radius: 6px;
				padding-left: 10px;
				padding-right: 10px;
				margin-right: 10px;
			}
		'';

		settings = [{
			margin = "0 20 6 20";
			layer = "top";
			position = "bottom";
			spacing = 0;

			# TODO: Volume widget?
      # TODO: Warning states for high usage?
			# TODO: Power menu?
			modules-left = [ "hyprland/workspaces" "hyprland/window" ];
			modules-center = [ "group/center" ];
			modules-right = [ "group/cpu-usage" "group/gpu-usage" "group/memory-usage" "bluetooth" "network" "tray" ];

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

			"hyprland/workspaces" = {
				persistent-workspaces = {
					"*" = 4;
				};
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
		}];
	};
}
