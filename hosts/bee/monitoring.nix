{config, ...}: {
  services.grafana = {
    enable = true;
    settings = {
      server = {
        http_addr = "0.0.0.0";
        http_port = 2342;
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

  # TODO: Loki

  # services.promtail = {
  #    enable = true;
  #    configuration = {
  #      server = {
  #        http_listen_port = 3031;
  #        grpc_listen_port = 0;
  #      };
  #      positions = {
  #        filename = "/tmp/positions.yaml";
  #      };
  #      clients = [{
  #        url = "http://127.0.0.1:${toString config.services.loki.configuration.server.http_listen_port}/loki/api/v1/push";
  #      }];
  #      scrape_configs = [{
  #        job_name = "journal";
  #        journal = {
  #          max_age = "12h";
  #          labels = {
  #            job = "systemd-journal";
  #            host = "${toString config.networking.hostName}";
  #          };
  #        };
  #        relabel_configs = [{
  #          source_labels = [ "__journal__systemd_unit" ];
  #          target_label = "unit";
  #        }];
  #      }];
  #    };
  #  };
}
