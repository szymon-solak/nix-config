{
  services.home-assistant = {
    config = {
      scene = [
        {
          name = "Day";
          entities = {
            "light.bedroom_lights" = "on";
            "light.bedroom_accent_lights" = "on";
            "light.kitchen_lights" = "on";
            "switch.alpstuga_air_quality_monitor" = "on";
          };
        }
      ];
    };
  };
}
