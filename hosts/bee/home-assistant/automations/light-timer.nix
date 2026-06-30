{
  services.home-assistant = {
    config = {
      timer = {
        lights_out = {
          duration = "00:30:00";
          icon = "mdi:sleep";
          restore = true;
        };
      };

      "automation lights_out" = {
        alias = "Turns off light once the timer runs out";
        description = "";
        mode = "single";
        triggers = [
          {
            platform = "event";
            event_type = "timer.finished";
            event_data = {
              entity_id = "timer.lights_out";
            };
          }
        ];
        actions = [
          {
            action = "scene.turn_on";
            target = {
              entity_id = "scene.night";
            };
          }
        ];
      };

      script = {
        start_or_extend_timer = {
          fields = {
            timer = {
              name = "Timer entity";
              selector = {
                entity = {
                  filter = [
                    {
                      domain = "time";
                    }
                  ];
                };
              };
            };
            time_in_minutes = {
              name = "Minutes";
              selector = {
                number = {
                  min = 0;
                  max = 120;
                  step = 5;
                  unit_of_measurement = "minutes";
                  mode = "slider";
                };
              };
            };
          };

          sequence = [
            {
              action = "timer.start";
              target = {
                entity_id = "{{ timer }}";
              };
              data = {
                duration = "{{ (state_attr(timer, 'finishes_at') | default(now(), true) | as_datetime - now() + timedelta(minutes=time_in_minutes)).total_seconds() | round(0) }}";
              };
            }
          ];
        };
      };
    };
  };
}
