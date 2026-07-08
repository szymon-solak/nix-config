{ lib, ... }:
let
  formatString = lib.replaceStrings [ "\t" "\n" ] [ " " " " ];

  sensors = [
    {
      temperature = "sensor.alpstuga_air_quality_monitor_temperature";
      humidity = "sensor.alpstuga_air_quality_monitor_humidity";
    }

    {
      temperature = "sensor.timmerflotte_temp_hmd_sensor_temperature";
      humidity = "sensor.timmerflotte_temp_hmd_sensor_humidity";
    }

    {
      temperature = "sensor.temperature_forecast_next_hour";
      humidity = "sensor.humidity_forecast_next_hour";
    }
  ];
in
{
  services.home-assistant = {
    config = {
      template = [
        {
          sensor = builtins.map (sensorConfig: {
            name = "Heat Index (${sensorConfig.temperature})";
            unique_id = "${sensorConfig.temperature}_heat_index";
            unit_of_measurement = "°C";
            state = formatString ''
              {% set t = (states('${sensorConfig.temperature}') | float) %}
              {% set h = (states('${sensorConfig.humidity}') | float) %}
              {{ "{:.1f}".format((t - 0.55 * (1 - 0.01 * h) * (t - 14.5))) }}
            '';
          }) sensors;
        }
      ];
    };
  };
}
