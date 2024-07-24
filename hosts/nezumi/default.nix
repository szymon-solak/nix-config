{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./stylix.nix
    ../modules/nix-settings.nix
    ../modules/polkit.nix
    ../modules/bluetooth.nix
    ../modules/ssh.nix
    ../modules/steam.nix
    ../modules/hyprland.nix
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
      permittedInsecurePackages = ["electron-25.9.0"];
    };
  };

  # boot.loader.efi.canTouchEfiVariables = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.timeout = 3;
  boot.loader.grub = {
    enable = true;
    devices = ["nodev"];
    efiSupport = true;
    # useOSProber = true;
    efiInstallAsRemovable = true;
    gfxmodeEfi = "3440x1440,auto";
    gfxmodeBios = "3440x1440,auto";
    # splashImage = null;
    extraConfig = ''
      insmod gfxterm
    '';
  };
  # boot.initrd.systemd.enable = true;

  networking.hostName = "nezumi";
  networking.networkmanager.enable = true;

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
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  programs.zsh.enable = true;
  programs.adb.enable = true;

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
  system.stateVersion = "23.11";
}
