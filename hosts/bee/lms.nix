{ pkgs, ... }:
{
  services.slimserver = {
    enable = true;
  };

  environment.systemPackages = [
    (pkgs.perl.withPackages (
      p: with p; [
        NetSSLeay
        CryptOpenSSLBignum
        CryptOpenSSLRSA
        IOSocketSSL
      ]
    ))
  ];

  systemd.services.slimserver.environment = {
    PERL5LIB = "${
      pkgs.perl.withPackages (
        p: with p; [
          NetSSLeay
          CryptOpenSSLBignum
          CryptOpenSSLRSA
          IOSocketSSL
        ]
      )
    }/${pkgs.perl.libPrefix}";
  };

  networking.firewall.allowedTCPPorts = [
    9000
    9090
    3483
    4070
  ];
  networking.firewall.allowedUDPPorts = [
    3483
    4070
  ];
}
