{
  services.home-assistant = {
    config = {
      "automation vacuum_around_litterboxe" = {
        alias = "Clean Litterboxes Automation";
        description = "";
        triggers = [
          {
            trigger = "state";
            entity_id = ["input_button.clean_litterboxes"];
          }
        ];
        conditions = [];
        actions = [
          {
            action = "vacuum.send_command";
            metadata = {};
            data = {
              command = "app_zoned_clean";
              params = [
                [
                  18200
                  25667
                  19465
                  26652
                  1
                ]
                [
                  23208
                  27306
                  24473
                  28290
                  1
                ]
              ];
            };
            target = {
              device_id = "ebe556e089c1d31f7aac9ccf6c9302fd";
            };
          }
        ];
        mode = "single";
      };
    };
  };
}
