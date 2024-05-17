{
  pkgs,
  pkgs-unstable,
  ...
}: let
in {
  home.packages = [
    pkgs-unstable.hypridle
    pkgs-unstable.hyprlock
  ];

  home.file.".config/hypr/hypridle.conf".text = ''
    listener {
    	timeout = 600
    	on-timeout = hyprlock
    }

    listener {
    	timeout = 900
    	on-timeout = hyprctl dispatch dpms off
    	on-resume = hyprctl dispatch dpms on
    }
  '';

  home.file.".config/hypr/hyprlock.conf".text = ''
    background {
    	monitor =
    	path = ${./lock.png}
    	blur_passes = 3
    	contrast = 0.8916
    	brightness = 0.8172
    	vibrancy = 0.1696
    	vibrancy_darkness = 0.0
    }

    general {
    	grace = 10
    }

    input-field {
    	monitor =
    	size = 400, 45
    	outline_thickness = 2
    	dots_size = 0.2
    	dots_spacing = 0.2
    	dots_center = true
    	outer_color = rgba(0, 0, 0, 0)
    	inner_color = rgba(0, 0, 0, 0.5)
    	font_color = rgb(200, 200, 200)
    	fade_on_empty = false
    	font_family = Iosevka Term
    	placeholder_text = <i>Input Password...</i> # Text rendered in the input box when it's empty.
    	hide_input = false
    	position = 0, -20
    	halign = center
    	valign = center
    }

    label {
    	monitor =
    	text = cmd[update:1000] echo "$(date +"%-I:%M%p")"
    	color = $foreground
    	#color = rgba(255, 255, 255, 0.6)
    	font_size = 120
    	font_family = Iosevka Term ExtraBold
    	position = 0, -300
    	halign = center
    	valign = top
    }

    label {
    	monitor =
    	text = Hi there, $USER
    	text_align = center # center/right or any value for default left. multi-line text alignment inside label container
    	color = rgba(200, 200, 200, 1.0)
    	font_size = 25
    	font_family = Iosevka Term

    	position = 0, 60
    	halign = center
    	valign = center
    }
  '';
}
