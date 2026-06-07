{
  services.home-assistant = {
    config = {
      template = [
        {
          triggers = [
            {
              trigger = "time_pattern";
              hours = "/1";
            }
          ];

          actions = [
            {
              action = "weather.get_forecasts";
              data = {
                type = "hourly";
              };
              target = {
                entity_id = "weather.forecast_home";
              };
              response_variable = "hourly";
            }
          ];

          sensor = [
            {
              name = "Temperature Forecast (Next hour)";
              unique_id = "temperate_forecast_next_hour";
              state = "{{ hourly['weather.forecast_home'].forecast[0].temperature }}";
              unit_of_measurement = "°C";
            }

            {
              name = "Humidity Forecast (Next hour)";
              unique_id = "humidity_forecast_next_hour";
              state = "{{ hourly['weather.forecast_home'].forecast[0].humidity }}";
              unit_of_measurement = "%";
            }

            {
              name = "Wind Speed Forecast (Next hour)";
              unique_id = "wind_speed_forecast_next_hour";
              state = "{{ hourly['weather.forecast_home'].forecast[0].wind_speed }}";
              unit_of_measurement = "km/h";
            }
          ];
        }
      ];
    };
  };
}
