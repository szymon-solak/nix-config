{config, ...}: let
  certs = "/var/lib/acme/pszczola.party";
in {
  age.secrets.cf.file = ./secrets/cf.age;

  security.acme = {
    acceptTerms = true;

    certs."pszczola.party" = {
      # Use age after https://github.com/NixOS/nixpkgs/issues/370825 is resolved
      email = "";
      group = config.services.caddy.group;

      domain = "pszczola.party";
      extraDomainNames = ["*.pszczola.party"];
      dnsProvider = "cloudflare";
      dnsResolver = "1.1.1.1:53";
      dnsPropagationCheck = true;
      environmentFile = config.age.secrets.cf.path;
    };
  };

  services.caddy = {
    enable = true;

    virtualHosts."bee.local".extraConfig = ''
      reverse_proxy http://localhost:8778
    '';

    virtualHosts."lms.bee.local".extraConfig = ''
      reverse_proxy http://localhost:9000
    '';

    virtualHosts."gf.bee.local".extraConfig = ''
      reverse_proxy http://localhost:${toString config.services.grafana.settings.server.http_port}
    '';

    virtualHosts."jellyfin.bee.local".extraConfig = ''
      reverse_proxy http://localhost:8096
    '';

    virtualHosts."home.bee.local".extraConfig = ''
      reverse_proxy http://localhost:${toString config.services.home-assistant.config.http.server_port}
    '';

    virtualHosts."dns.bee.local".extraConfig = ''
      reverse_proxy http://localhost:${toString config.services.pihole-web.ports}
    '';

    virtualHosts."pszczola.party".extraConfig = ''
      reverse_proxy http://localhost:8778

      tls ${certs}/cert.pem ${certs}/key.pem {
      	protocols tls1.3
      }
    '';

    virtualHosts."lms.pszczola.party".extraConfig = ''
      reverse_proxy http://localhost:9000

      tls ${certs}/cert.pem ${certs}/key.pem {
      	protocols tls1.3
      }
    '';

    virtualHosts."gf.pszczola.party".extraConfig = ''
      reverse_proxy http://localhost:${toString config.services.grafana.settings.server.http_port}

      tls ${certs}/cert.pem ${certs}/key.pem {
      	protocols tls1.3
      }
    '';

    virtualHosts."jellyfin.pszczola.party".extraConfig = ''
      reverse_proxy http://localhost:8096

      tls ${certs}/cert.pem ${certs}/key.pem {
      	protocols tls1.3
      }
    '';

    virtualHosts."home.pszczola.party".extraConfig = ''
      reverse_proxy http://localhost:${toString config.services.home-assistant.config.http.server_port}

      tls ${certs}/cert.pem ${certs}/key.pem {
      	protocols tls1.3
      }
    '';

    virtualHosts."dns.pszczola.party".extraConfig = ''
      reverse_proxy http://localhost:${toString config.services.pihole-web.ports}

      tls ${certs}/cert.pem ${certs}/key.pem {
      	protocols tls1.3
      }
    '';
  };
}
