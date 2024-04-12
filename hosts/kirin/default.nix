{ inputs, lib, config, pkgs, ... }:
let
  plymouth_themes = pkgs.adi1090x-plymouth-themes.override {
    selected_themes = [ "hexagon_dots" ];
  };
in {
  imports = [ ./hardware-configuration.nix ./polkit.nix ];

  nixpkgs = {
    overlays = [ ];

    config = {
      allowUnfreePredicate = pkg:
        builtins.elem (lib.getName pkg) [
          "obsidian"
          "terraform"
          "steam"
          "steam-original"
          "steam-run"
        ];
      permittedInsecurePackages = [ "electron-24.8.6" "electron-25.9.0" ];
    };

  };

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
    extraOptions = "	keep-outputs = true\n	keep-derivations = true\n";
  };

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.timeout = 1;
  boot.loader.grub = {
    enable = true;
    devices = [ "nodev" ];
    efiSupport = true;
    useOSProber = true;
  };
  boot.plymouth = {
    enable = true;
    themePackages = [ plymouth_themes ];
    theme = "hexagon_dots";
  };

  networking.hostName = "kirin";
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
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome = {
    enable = true;
    extraGSettingsOverrides =
      "	[org.gnome.desktop.peripherals.keyboard]\n	delay=150\n	repeat-interval=30\n";
  };

  programs.hyprland.enable = true;
  services.udisks2.enable = true;
  services.udev.packages = [ pkgs.via ];

  # Configure keymap in X11
  services.xserver = {
    layout = "pl,us";
    xkbVariant = "";
  };

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

  users.users.szymon = {
    isNormalUser = true;
    description = "szymon";
    extraGroups = [ "networkmanager" "wheel" "dialout" ];
    shell = pkgs.zsh;
    packages = with pkgs; [ git gcc ];
  };

  security.sudo.enable = false;
  security.sudo-rs.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "22.11";
}
