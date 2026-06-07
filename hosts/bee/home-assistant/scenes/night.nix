{
  services.home-assistant = {
    config = {
      scene = [
        {
          name = "Night";
          entities = {
            "light.bedroom_lights" = "off";
            "light.bedroom_accent_lights" = "off";
            "light.kitchen_lights" = "off";
            "switch.alpstuga_air_quality_monitor" = "off";
          };
        }
      ];
    };
  };
}
