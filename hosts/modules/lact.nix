{
  services.lact = {
    enable = true;
    settings = {
      version = 5;
      apply_settings_timer = 5;
      current_profile = null;
      auto_switch_profiles = false;

      daemon = {
        log_level = "info";
        admin_group = "wheel";
        disable_clocks_cleanup = false;
      };

      gpus = {
        "1002:7480-1025:B477-0000:03:00.0" = {
          fan_control_enabled = false;
          pmfw_options = {
            acoustic_limit = 3000;
            target_temperature = 75;
            zero_rpm = false;
          };
          power_cap = 140;
          performace_level = "auto";
          max_core_clock = 2600;
          voltage_offset = -65;
        };
      };
    };
  };
}
