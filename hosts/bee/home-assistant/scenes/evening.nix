{
  services.home-assistant = {
    config = {
      scene = [
        {
          name = "Evening";
          entities = {
            "light.bedroom_lights" = {
              state = "on";
              rgb_color = [255 140 0];
              brightness = 160;
            };

            "light.bedroom_accent_lights" = {
              state = "on";
              rgb_color = [255 140 0];
              brightness = 160;
            };

            "light.kitchen_lights" = {
              state = "on";
              rgb_color = [255 140 0];
              brightness = 160;
            };

            "switch.alpstuga_air_quality_monitor" = "on";
          };
        }
      ];
    };
  };
}
