{
  services.home-assistant = {
    config = {
      light = [
        {
          platform = "group";
          name = "Bedroom Lights";
          entities = [
            "light.yeelink_de_132966381_color2_s_2_light"
            "light.yeelink_de_132001292_color2_s_2_light"
            "light.kajplats_gu10_cws_470lm"
            "light.kajplats_gu10_cws_470lm_2"
          ];
        }

        {
          platform = "group";
          name = "Bedroom Accent Lights";
          entities = [
            "light.varmblixt_table_wall_lamp"
          ];
        }

        {
          platform = "group";
          name = "Kitchen Lights";
          entities = [
            "light.kitchen_strip"
            "light.kajplats_e14_cws_globe_806lm"
          ];
        }
      ];
    };
  };
}
