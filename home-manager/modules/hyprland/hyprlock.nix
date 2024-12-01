{pkgs, ...}: {
  home.packages = [
    pkgs.hypridle
  ];

  services.hypridle = {
    enable = true;
    settings = {
      listener = [
        {
          timeout = 900;
          on-timeout = "hyprlock";
        }
        {
          timeout = 1500;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };

  programs.hyprlock = {
    enable = true;
    settings = {
      background = {
        # path = "${./lock.png}";
        blur_passes = 3;
        contrast = 0.9;
        brightness = 0.8;
        vibrancy = 0.16;
        vibrancy_darkness = 0.0;
      };

      general = {
        grace = 10;
      };

      input-field = {
        size = "400, 45";
        outline_thickness = 2;
        dots_size = 0.2;
        dots_spacing = 0.2;
        dots_center = true;
        # outer_color = "rgba(0, 0, 0, 0)";
        # inner_color = "rgba(0, 0, 0, 0.5)";
        # font_color = "rgb(200, 200, 200)";
        fade_on_empty = false;
        placeholder_text = "<i>Input Password...</i>";
        hide_input = false;
        position = "0, -20";
        halign = "center";
        valign = "center";
      };

      label = {
        text = ''
          cmd[update:1000] echo "$(date +"%-I:%M%p")"
        '';
        color = "rgba(255, 255, 255, 0.6)";
        font_size = 120;
        font_family = "Iosevka Term ExtraBold";
        position = "0, -300";
        halign = "center";
        valign = "top";
      };
    };
  };
}
