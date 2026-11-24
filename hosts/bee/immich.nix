{
  services.immich = {
    enable = true;
    port = 2283;
    host = "0.0.0.0";

    mediaLocation = "/data/Photos";
  };

  # Hardware transcoding
  services.immich.accelerationDevices = null;
  users.users.immich.extraGroups = [
    "video"
    "render"
  ];

  # Reduce logs verbosity
  services.redis.servers.immich.logLevel = "warning";
  services.immich.environment.IMMICH_LOG_LEVEL = "warn";
}
