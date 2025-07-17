{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../modules/nix-settings.nix
    ../modules/glance.nix
    ../modules/jellyfin.nix
    ../modules/mdns.nix
    ../modules/samba.nix
    ./caddy.nix
    ./monitoring.nix
    ./lms.nix
  ];

  nix.settings.trusted-users = ["bee"];
  security.pam.sshAgentAuth.enable = true;
  nix.package = pkgs.nixVersions.nix_2_28;
  nixpkgs = {
    overlays = [];

    config = {
      allowUnfreePredicate = pkg:
        builtins.elem (lib.getName pkg) [
          "intel-ocl"
        ];
      permittedInsecurePackages = [];
    };
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "bee";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Warsaw";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };

  services.xserver.xkb = {
    layout = "pl";
    variant = "";
  };

  console.keyMap = "pl2";

  users.users.bee = {
    isNormalUser = true;
    description = "bee";
    extraGroups = ["networkmanager" "wheel"];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKgYrw3DhPtjLsF71tIhpw1YRDIWrqiLY9ldVHh3G6rp szymon"
    ];
  };

  services.getty.autologinUser = "bee";

  environment.systemPackages = with pkgs; [neovim];

  services.openssh = {
    enable = true;
    ports = [22];
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  networking.firewall.allowedTCPPorts = [80 443 22];

  system.stateVersion = "24.11"; # Did you read the comment?
}
