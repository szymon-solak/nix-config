{
  services.home-assistant = {
    config = {
      media_player = [
        {
          platform = "group";
          name = "Players";
          entities = [
            "media_player.squeezebox_radio_black"
            "media_player.squeezebox_radio_white"
          ];
        }
      ];
    };
  };
}
