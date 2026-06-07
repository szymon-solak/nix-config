{
  services.home-assistant = {
    config = {
      schedule = {
        day_mode = {
          name = "Day Mode";
          monday = {
            from = "08:00";
            to = "23:30";
          };
          tuesday = {
            from = "08:00";
            to = "23:30";
          };
          wednesday = {
            from = "08:00";
            to = "23:30";
          };
          thursday = {
            from = "08:00";
            to = "23:30";
          };
          friday = {
            from = "08:00";
            to = "23:30";
          };
          saturday = {
            from = "08:00";
            to = "23:30";
          };
          sunday = {
            from = "08:00";
            to = "23:30";
          };
        };
      };

      "automation enable_day_mode" = {
        alias = "Enable Day Mode";
        description = "";
        triggers = [
          {
            trigger = "state";
            entity_id = ["schedule.day_mode"];
            to = "on";
          }
        ];
        actions = [
          {
            action = "scene.turn_on";
            target = {
              entity_id = "scene.day";
            };
          }
        ];
      };

      "automation disable_day_mode" = {
        alias = "Disable Day Mode";
        description = "";
        triggers = [
          {
            trigger = "state";
            entity_id = ["schedule.day_mode"];
            to = "off";
          }
        ];
        conditions = [
          {
            condition = "state";
            entity_id = "timer.lights_out";
            state = "idle";
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
    };
  };
}
