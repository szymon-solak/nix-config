{
  services.glance = {
    enable = true;

    settings.server = {
      host = "0.0.0.0";
      port = 8778;
    };

    settings.theme = {
      "background-color" = "240 21 15";
      "contrast-multiplier" = 1.2;
      "primary-color" = "217 92 83";
      "positive-color" = "115 54 76";
      "negative-color" = "347 70 65";
    };

    settings.pages = [
      {
        name = "Home";
        columns = [
          {
            size = "small";
            widgets = [
              {type = "calendar";}
              {
                type = "weather";
                location = "Gliwice, Poland";
              }
            ];
          }
          {
            size = "full";
            widgets = [
              {type = "hacker-news";}
              {type = "lobsters";}
            ];
          }
          {
            size = "small";
            widgets = [
              {
                type = "monitor";
                cache = "5m";
                title = "Services";
                sites = [
                  {
                    title = "Grafana";
                    url = "https://gf.pszczola.party";
                    icon = "si:grafana";
                  }
                  {
                    title = "Lyrion";
                    url = "https://lms.pszczola.party";
                  }
                  {
                    title = "Jellyfin";
                    url = "http://jellyfin.pszczola.party";
                    icon = "si:jellyfin";
                  }
                ];
              }
            ];
          }
        ];
      }
    ];
  };
}
