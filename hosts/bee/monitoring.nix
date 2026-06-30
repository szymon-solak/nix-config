{config, ...}: {
  services.grafana = {
    enable = true;
    settings = {
      server = {
        http_addr = "0.0.0.0";
        http_port = 2342;
      };
      security = {
        # @todo: Rotate and use file provider
        secret_key = "SW2YcwTIb9zpOOhoPsMm";
      };
    };
  };

  services.prometheus = {
    enable = true;
    port = 9001;

    exporters = {
      node = {
        enable = true;
        enabledCollectors = ["systemd"];
        port = 9002;
      };
    };

    scrapeConfigs = [
      {
        job_name = "bee";
        static_configs = [
          {
            targets = ["127.0.0.1:${toString config.services.prometheus.exporters.node.port}"];
          }
        ];
      }
    ];
  };

  services.loki = {
    enable = true;
    configuration = {
      auth_enabled = false;

      server = {
        http_listen_port = 3100;
      };

      common = {
        ring = {
          instance_addr = "127.0.0.1";
          kvstore = {
            store = "inmemory";
          };
        };

        replication_factor = 1;
        path_prefix = "/tmp/loki";
      };

      schema_config = {
        configs = [
          {
            from = "2020-05-15";
            store = "tsdb";
            object_store = "filesystem";
            schema = "v13";
            index = {
              prefix = "index_";
              period = "24h";
            };
          }
        ];
      };

      storage_config = {
        filesystem = {
          directory = "/tmp/loki/chunks";
        };
      };
    };
  };

  environment.etc."alloy/config.alloy" = {
    text = ''
      discovery.relabel "journal" {
      	targets = []

      	rule {
      		source_labels = ["__journal__systemd_unit"]
      		target_label  = "unit"
      	}
      }

      loki.source.journal "journal" {
      	max_age       = "12h0m0s"
      	relabel_rules = discovery.relabel.journal.rules
      	forward_to    = [loki.write.default.receiver]
      	labels        = {
      		host = "${toString config.networking.hostName}",
      		job  = "systemd-journal",
      	}
      }

      loki.write "default" {
      	endpoint {
      		url = "http://127.0.0.1:${toString config.services.loki.configuration.server.http_listen_port}/loki/api/v1/push"
      	}
      	external_labels = {}
      }
    '';
  };

  services.alloy.enable = true;
}
