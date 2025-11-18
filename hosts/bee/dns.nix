{config, ...}: {
  services.blocky = {
    enable = true;

    settings = {
      ports.dns = 53;
      ports.http = 4000;
      upstreams.groups.default = [
        "https://one.one.one.one/dns-query"
      ];

      bootstrapDns = {
        upstream = "https://one.one.one.one/dns-query";
        ips = [
          "1.1.1.1"
          "1.0.0.1"
        ];
      };

      blocking = {
        blackLists = {
          ads = ["https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"];
        };
        clientGroupsBlock = {
          default = ["ads"];
        };
      };

      prometheus.enable = config.services.prometheus.enable;
    };
  };

  services.prometheus = {
    scrapeConfigs = [
      {
        job_name = "blocky";
        static_configs = [
          {
            targets = ["127.0.0.1:${toString config.services.blocky.settings.ports.http}"];
          }
        ];
      }
    ];
  };

  networking.firewall.allowedTCPPorts = [
    config.services.blocky.settings.ports.dns
  ];
}
