{
  services.home-assistant = {
    config = {
      adaptive_lighting = [
        {
          name = "default";
          lights = [
            "light.bedroom_lights"
            "light.kitchen_lights"
          ];
          initial_transition = 0;
          min_brightness = 25;
          min_color_temp = 2500;
          max_color_temp = 5500;
          prefer_rgb_color = true;
          detect_non_ha_changes = true;
          skip_redundant_commands = true;
        }

        {
          name = "accent";
          lights = [
            "light.bedroom_accent_lights"
          ];
          initial_transition = 0;
          min_brightness = 50;
          min_color_temp = 1800;
          max_color_temp = 4500;
          detect_non_ha_changes = true;
          skip_redundant_commands = true;
        }
      ];
    };
  };
}
