{lib, ...}: let
  formatString = lib.replaceStrings ["\t" "\n"] [" " " "];
in {
  services.home-assistant = {
    config = {
      "automation scroll_remote" = {
        alias = "Scroll remote";
        description = "";
        mode = "queued";
        max = 100;
        max_exceeded = "silent";

        triggers = [
          {
            id = "button_ch1";
            trigger = "event";
            event_type = "state_changed";
            event_data = {
              entity_id = "event.bilresa_scroll_wheel_button_3";
            };
          }
          {
            id = "scroll_left_ch1";
            trigger = "event";
            event_type = "state_changed";
            event_data = {
              entity_id = "event.bilresa_scroll_wheel_button_2";
            };
          }
          {
            id = "scroll_right_ch1";
            trigger = "event";
            event_type = "state_changed";
            event_data = {
              entity_id = "event.bilresa_scroll_wheel_button_1";
            };
          }
          {
            id = "scroll_left_ext_ch1";
            trigger = "event";
            event_type = "state_changed";
            event_data = {
              entity_id = "sensor.bilresa_scroll_wheel_current_switch_position_2";
            };
          }
          {
            id = "scroll_right_ext_ch1";
            trigger = "event";
            event_type = "state_changed";
            event_data = {
              entity_id = "sensor.bilresa_scroll_wheel_current_switch_position_1";
            };
          }

          {
            id = "button_ch2";
            trigger = "event";
            event_type = "state_changed";
            event_data = {
              entity_id = "event.bilresa_scroll_wheel_button_6";
            };
          }
          {
            id = "scroll_left_ch2";
            trigger = "event";
            event_type = "state_changed";
            event_data = {
              entity_id = "event.bilresa_scroll_wheel_button_5";
            };
          }
          {
            id = "scroll_right_ch2";
            trigger = "event";
            event_type = "state_changed";
            event_data = {
              entity_id = "event.bilresa_scroll_wheel_button_4";
            };
          }
          {
            id = "scroll_left_ext_ch2";
            trigger = "event";
            event_type = "state_changed";
            event_data = {
              entity_id = "sensor.bilresa_scroll_wheel_current_switch_position_5";
            };
          }
          {
            id = "scroll_right_ext_ch2";
            trigger = "event";
            event_type = "state_changed";
            event_data = {
              entity_id = "sensor.bilresa_scroll_wheel_current_switch_position_4";
            };
          }

          {
            id = "button_ch3";
            trigger = "event";
            event_type = "state_changed";
            event_data = {
              entity_id = "event.bilresa_scroll_wheel_button_9";
            };
          }
          {
            id = "scroll_left_ch3";
            trigger = "event";
            event_type = "state_changed";
            event_data = {
              entity_id = "event.bilresa_scroll_wheel_button_8";
            };
          }
          {
            id = "scroll_right_ch3";
            trigger = "event";
            event_type = "state_changed";
            event_data = {
              entity_id = "event.bilresa_scroll_wheel_button_7";
            };
          }
          {
            id = "scroll_left_ext_ch3";
            trigger = "event";
            event_type = "state_changed";
            event_data = {
              entity_id = "sensor.bilresa_scroll_wheel_current_switch_position_8";
            };
          }
          {
            id = "scroll_right_ext_ch3";
            trigger = "event";
            event_type = "state_changed";
            event_data = {
              entity_id = "sensor.bilresa_scroll_wheel_current_switch_position_7";
            };
          }
        ];

        conditions = [
          {
            condition = "template";
            value_template = formatString ''
              {{
              	trigger.event.data.old_state.state != 'unavailable'
              	and trigger.event.data.new_state.state != 'unavailable'
              }}
            '';
          }
        ];

        actions = [
          {
            variables = {
              channel = formatString ''
                {% if trigger.id in ['button_ch1', 'scroll_left_ch1', 'scroll_right_ch1', 'scroll_left_ext_ch1', 'scroll_right_ext_ch1'] %}
                	ch1
                {% elif trigger.id in ['button_ch2', 'scroll_left_ch2', 'scroll_right_ch2', 'scroll_left_ext_ch2', 'scroll_right_ext_ch2'] %}
                	ch2
                {% elif trigger.id in ['button_ch3', 'scroll_left_ch3', 'scroll_right_ch3', 'scroll_left_ext_ch3', 'scroll_right_ext_ch3'] %}
                	ch3
                {% endif %}
              '';
            };
          }

          {
            choose = [
              # Button click
              {
                conditions = [
                  {
                    condition = "template";
                    value_template = ''
                      {{ trigger.id == ('button_' ~ channel) and trigger.event.data.new_state.attributes.event_type == 'multi_press_1' }}
                    '';
                  }
                ];
                sequence = [
                  {
                    "if" = "{{ channel == 'ch1'}}";
                    "then" = {
                      action = "media_player.media_play_pause";
                      target = {
                        entity_id = "media_player.players";
                      };
                    };
                  }
                ];
              }

              # Button double-click
              {
                conditions = [
                  {
                    condition = "template";
                    value_template = ''
                      {{ trigger.id == ('button_' ~ channel) and trigger.event.data.new_state.attributes.event_type == 'multi_press_2' }}
                    '';
                  }
                ];
                sequence = [
                  {
                    "if" = "{{ channel == 'ch1'}}";
                    "then" = {
                      action = "media_player.media_next_track";
                      target = {
                        entity_id = "media_player.players";
                      };
                    };
                  }
                ];
              }

              # Button triple-click
              {
                conditions = [
                  {
                    condition = "template";
                    value_template = ''
                      {{ trigger.id == ('button_' ~ channel) and trigger.event.data.new_state.attributes.event_type == 'multi_press_3' }}
                    '';
                  }
                ];
                sequence = [
                  {
                    "if" = "{{ channel == 'ch1'}}";
                    "then" = {
                      action = "media_player.media_previous_track";
                      target = {
                        entity_id = "media_player.players";
                      };
                    };
                  }
                ];
              }

              # Button long-press
              {
                conditions = [
                  {
                    condition = "template";
                    value_template = ''
                      {{ trigger.id == ('button_' ~ channel) and trigger.event.data.new_state.attributes.event_type == 'long_press' }}
                    '';
                  }
                ];
                sequence = [
                  {
                    "if" = "{{ channel == 'ch1'}}";
                    "then" = {
                      action = "media_player.toggle";
                      target = {
                        entity_id = "media_player.players";
                      };
                    };
                  }
                ];
              }

              # Scroll wheel
              {
                conditions = [
                  {
                    condition = "template";
                    value_template = ''
                      {{ (trigger.id == ('scroll_left_ext_' ~ channel) or trigger.id == ('scroll_right_ext_' ~ channel)) and trigger.event.data.new_state.state == '1' }}
                    '';
                  }
                ];
                sequence = [
                  {
                    variables = {
                      scroll_direction = formatString ''
                        {% if (trigger.id == 'scroll_left_' ~ channel) or (trigger.id == 'scroll_left_ext_' ~ channel)%}
                        	left
                        {% else %}
                        	right
                        {% endif %}
                      '';
                    };
                  }
                  {
                    choose = [
                      {
                        conditions = [
                          {
                            condition = "template";
                            value_template = "{{ scroll_direction == 'left' }}";
                          }
                        ];
                        sequence = [
                          {
                            action = "media_player.volume_set";
                            data = {
                              volume_level = "{{ state_attr('media_player.squeezebox_radio_black', 'volume_level') - 0.02 }}";
                            };
                            target = {
                              entity_id = "media_player.squeezebox_radio_black";
                            };
                          }
                          {
                            action = "media_player.volume_set";
                            data = {
                              volume_level = "{{ state_attr('media_player.squeezebox_radio_white', 'volume_level') - 0.02 }}";
                            };
                            target = {
                              entity_id = "media_player.squeezebox_radio_white";
                            };
                          }
                        ];
                      }

                      {
                        conditions = [
                          {
                            condition = "template";
                            value_template = "{{ scroll_direction == 'right' }}";
                          }
                        ];
                        sequence = [
                          {
                            action = "media_player.volume_set";
                            data = {
                              volume_level = "{{ state_attr('media_player.squeezebox_radio_black', 'volume_level') + 0.02 }}";
                            };
                            target = {
                              entity_id = "media_player.squeezebox_radio_black";
                            };
                          }
                          {
                            action = "media_player.volume_set";
                            data = {
                              volume_level = "{{ state_attr('media_player.squeezebox_radio_white', 'volume_level') + 0.02 }}";
                            };
                            target = {
                              entity_id = "media_player.squeezebox_radio_white";
                            };
                          }
                        ];
                      }
                    ];
                  }
                ];
              }
            ];
          }
        ];
      };
    };
  };
}
