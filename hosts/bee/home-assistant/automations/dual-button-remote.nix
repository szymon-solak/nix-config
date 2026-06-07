{
  services.home-assistant = {
    config = {
      "automation dual_button_remote" = {
        alias = "Dual button remote";
        description = "";
        mode = "restart";

        triggers = [
          {
            id = "button1";
            trigger = "state";
            entity_id = ["event.bilresa_dual_button_button_1"];
            not_from = "unavailable";
            not_to = "unavailable";
          }

          {
            id = "button2";
            trigger = "state";
            entity_id = ["event.bilresa_dual_button_button_2"];
            not_from = "unavailable";
            not_to = "unavailable";
          }
        ];

        conditions = [];

        actions = [
          {
            variables = {
              press_type = "{{ trigger.to_state.attributes.event_type }}";
              trigger_id = "{{ trigger.id }}";
            };
          }
          {
            choose = [
              # Button 1
              {
                conditions = [
                  {
                    condition = "template";
                    value_template = "{{ trigger_id == 'button1' and press_type == 'multi_press_1' }}";
                  }
                ];
                sequence = [
                  {
                    action = "switch.toggle";
                    target = {
                      entity_id = "switch.grillplats_plug";
                    };
                  }
                ];
              }

              {
                conditions = [
                  {
                    condition = "template";
                    value_template = "{{ trigger_id == 'button1' and press_type == 'multi_press_2' }}";
                  }
                ];
                sequence = [];
              }

              {
                conditions = [
                  {
                    condition = "template";
                    value_template = "{{ trigger_id == 'button1' and press_type == 'long_press' }}";
                  }
                ];
                sequence = [];
              }

              # Button 2
              {
                conditions = [
                  {
                    condition = "template";
                    value_template = "{{ trigger_id == 'button2' and press_type == 'multi_press_1' }}";
                  }
                ];
                sequence = [];
              }

              {
                conditions = [
                  {
                    condition = "template";
                    value_template = "{{ trigger_id == 'button2' and press_type == 'multi_press_2' }}";
                  }
                ];
                sequence = [];
              }

              {
                conditions = [
                  {
                    condition = "template";
                    value_template = "{{ trigger_id == 'button2' and press_type == 'long_press' }}";
                  }
                ];
                sequence = [];
              }
            ];
          }
        ];
      };
    };
  };
}
