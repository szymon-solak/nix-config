{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        ControllerMode = "bredr";
        # Enable = "Source,Sink,Media,Socket";
        # FastConnectable = true;
        Experimental = true;
      };
      # Policy = {
      #   ReconnectAttempts = 7;
      #   ReconnectIntervals = "1,2,4,8,16,32,64";
      # };
    };
  };

  # services.blueman.enable = true;
}
