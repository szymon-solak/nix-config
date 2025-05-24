{pkgs, ...}: let
  go-avahi-cname = with pkgs;
    buildGoModule rec {
      pname = "go-avahi-cname";
      version = "2.2.5";

      src = fetchFromGitHub {
        owner = "grishy";
        repo = "go-avahi-cname";
        rev = "v${version}";
        hash = "sha256-K5Pis+11Kf2IeXoZbk8kTqtxurRAfBEVUCBNc4eLdLM=";
      };

      vendorHash = "sha256-X6OnO5Mucj12+CjtOBpy3oH4KOCygb63JjPjyFWk1A8=";
    };
in {
  environment.systemPackages = with pkgs; [
    nssmdns
    avahi
    go-avahi-cname
  ];

  services.avahi = {
    nssmdns4 = true;
    enable = true;
    ipv4 = true;
    ipv6 = true;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
      # This is needed avoid avahi throwing 'Not permitted' while
      # registering new entries (like subdomains by go-avahi-cname)
      userServices = true;
    };
  };

  systemd.services.avahi-cname = {
    description = "Avahi CNAME Publisher";
    wantedBy = ["multi-user.target"];
    after = [
      "network.target"
      "avahi-daemon.service"
    ];
    requires = ["avahi-daemon.service"];

    serviceConfig = {
      Type = "simple";
      User = "root"; # Needs root for Avahi access
      ExecStart = "${go-avahi-cname}/bin/go-avahi-cname subdomain";
      Restart = "always";
      RestartSec = "10";
    };
  };
}
