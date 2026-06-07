{
  lib,
  config,
  pkgs,
  utils,
  ...
}: let
  cfg = config.services.matter-waker;
in {
  options.services.matter-waker = {
    enable = lib.mkEnableOption "Matter Waker";

    package = lib.mkPackageOption pkgs "matter-waker" {};

    nodes = lib.mkOption {
      type = lib.types.listOf lib.types.int;
      default = [];
      description = "Node ids to wake up.";
    };

    address = lib.mkOption {
      type = lib.types.str;
      default = "ws://127.0.0.1:5580/ws";
      description = "Address of the Matter server.";
    };

    timeout = lib.mkOption {
      type = lib.types.int;
      default = 15;
      description = "Keep waiting for events at least this many seconds.";
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services = {
      matter-waker = {
        description = "Matter Waker";
        wantedBy = ["multi-user.target"];
        requires = ["network-online.target"];
        after = ["network-online.target"];
        # Run every 2 minutes
        # TODO: Param?
        startAt = ["*:0/2"];
        serviceConfig = {
          Type = "oneshot";
          ExecStart = lib.concatStringsSep " " (
            lib.concatLists [
              [
                (lib.getExe' cfg.package "matter-waker")
              ]
              (map (node: "--node ${utils.escapeSystemdExecArg node}") cfg.nodes)
              [
                "--timeout ${utils.escapeSystemdExecArg cfg.timeout}"
                "--address ${utils.escapeSystemdExecArg cfg.address}"
              ]
            ]
          );

          StateDirectory = "matter-waker";
          ProtectSystem = "strict";
          ProtectHome = true;
          PrivateTmp = true;
          ProtectKernelLogs = true;
          ProtectControlGroups = true;
          NoNewPrivileges = true;
          LockPersonality = true;
          RestrictRealtime = true;
          RestrictSUIDSGID = true;
          SystemCallArchitectures = "native";

          CapabilityBoundingSet = [
            "CAP_NET_ADMIN"
            "CAP_NET_RAW"
          ];
        };
      };
    };
  };
}
