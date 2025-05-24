{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./stylix.nix
    ../modules/nix-settings.nix
    ../modules/bluetooth.nix
    ../modules/ssh.nix
    ../modules/steam.nix
    ../modules/sddm.nix
    ../modules/lact.nix
  ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };

  nixpkgs = {
    overlays = [];

    config = {
      allowUnfreePredicate = pkg:
        builtins.elem (lib.getName pkg) [
          "obsidian"
          "terraform"
          "steam"
          "steam-original"
          "steam-run"
        ];
      permittedInsecurePackages = [];
    };
  };

  environment.systemPackages = [pkgs.sbctl];
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.loader.timeout = 2;
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot/";
    # pkiBundle = "/var/lib/sbctl";
  };

  networking.hostName = "nezumi";
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "iwd";
  networking.networkmanager.dns = "systemd-resolved";
  networking.networkmanager.connectionConfig = {
    mdns = 2;
  };
  networking.wireless.iwd = {
    enable = true;
    settings = {
      IPv6.Enabled = true;
      Settings.AutoConnect = true;
    };
  };
  networking.nameservers = ["1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one"];

  services.resolved = {
    enable = true;
    domains = ["~."];
    fallbackDns = ["1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one"];
    dnsovertls = "true";
  };

  services.avahi.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # Select internationalisation properties.
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

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    videoDrivers = ["amdgpu"];
    xkb = {
      variant = "";
      layout = "pl,us";
    };
  };

  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.udev.packages = [pkgs.via];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  programs.zsh.enable = true;
  programs.adb.enable = true;
  programs.nm-applet.enable = true;
  programs.xwayland.enable = true;
  programs.niri.enable = true;
  services.displayManager.sessionPackages = [pkgs.niri];
  services.fwupd.enable = true;
  security.pam.services.swaylock = {};

  programs.uwsm = {
    enable = true;
    waylandCompositors = {
      niri = {
        prettyName = "Niri";
        comment = "Hyprland compositor managed by UWSM";
        binPath = "/run/current-system/sw/bin/niri-session";
      };
    };
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  users.users.szymon = {
    isNormalUser = true;
    description = "szymon";
    extraGroups = ["networkmanager" "wheel" "dialout" "adbusers"];
    shell = pkgs.zsh;
    packages = with pkgs; [git gcc];
  };

  security.sudo.enable = false;
  security.sudo-rs.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.11";
}
