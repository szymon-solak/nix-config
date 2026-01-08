{config, ...}: {
  services.pihole-ftl = {
    enable = true;
    openFirewallDNS = true;
    lists = [
      {
        url = "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts";
      }
    ];
    settings = {
      dns = {
        upstreams = [
          "1.1.1.1"
          "1.0.0.1"
          "2606:4700:4700::1111"
          "2606:4700:4700::1001"
        ];
      };
    };
  };

  services.pihole-web = {
    enable = true;
    ports = [7777];
  };

  services.prometheus.exporters.pihole = {
    enable = true;
    piholeHostname = "127.0.0.1";
    piholePort = 7777;
    # @todo: password or api token
  };

  services.prometheus = {
    scrapeConfigs = [
      {
        job_name = "pihole";
        static_configs = [
          {
            targets = ["127.0.0.1:${toString config.services.prometheus.exporters.pihole.port}"];
          }
        ];
      }
    ];
  };

  #
  # services.prometheus = {
  #   scrapeConfigs = [
  #     {
  #       job_name = "blocky";
  #       static_configs = [
  #         {
  #           targets = [ "127.0.0.1:${toString config.services.blocky.settings.ports.http}" ];
  #         }
  #       ];
  #     }
  #   ];
  # };
  #
  # networking.firewall.allowedTCPPorts = [
  #   config.services.blocky.settings.ports.dns
  # ];
}
