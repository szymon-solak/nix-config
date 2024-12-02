{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../modules/nix-settings.nix
    ./stylix.nix
    ./sketchybar
  ];

	system.stateVersion = 5;

  services.nix-daemon.enable = true;

  nix.gc = {
    automatic = true;
    interval = {
      Weekday = 0;
      Hour = 0;
      Minute = 0;
    };
    options = "--delete-older-than 1w";
  };

  programs.zsh = {
    enable = true;
    promptInit = "";
  };

  users.users.szymonsolak = {
    name = "szymonsolak";
    home = "/Users/szymonsolak/";
  };

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) ["obsidian" "terraform" "tart"];

  system = {
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
    defaults = {
      dock = {
        autohide = true;
        showhidden = true;
        mru-spaces = false;
      };
      finder = {
        AppleShowAllExtensions = true;
        QuitMenuItem = true;
        FXEnableExtensionChangeWarning = true;
      };
      NSGlobalDomain = {
        _HIHideMenuBar = true;
        InitialKeyRepeat = 10;
        KeyRepeat = 1;
        NSWindowShouldDragOnGesture = true;
      };
      screencapture.location = "~/Pictures";
    };
  };

  services.skhd = {
    enable = true;
    package = pkgs.skhd;
    skhdConfig = ''
      cmd - return : kitty --single-instance

         lalt - j : yabai -m window --focus south || yabai -m display --focus south
      lalt - h : yabai -m window --focus west  || yabai -m display --focus west
         lalt - k : yabai -m window --focus north || yabai -m display --focus north
         lalt - l : yabai -m window --focus east  || yabai -m display --focus east

      shift + lalt - f : yabai -m window --toggle zoom-fullscreen; sketchybar --trigger window_focus

      shift + lalt - h : yabai -m window --warp west
      shift + lalt - j : yabai -m window --warp south
      shift + lalt - k : yabai -m window --warp north
      shift + lalt - l : yabai -m window --warp east

      shift + lalt - s : yabai -m window --toggle split

      shift + lalt - 1 : yabai -m window --space 1;
         shift + lalt - 2 : yabai -m window --space 2;
         shift + lalt - 3 : yabai -m window --space 3;
         shift + lalt - 4 : yabai -m window --space 4;
         shift + lalt - 5 : yabai -m window --space 5;
         shift + lalt - 6 : yabai -m window --space 6;
         shift + lalt - 7 : yabai -m window --space 7;
         shift + lalt - 8 : yabai -m window --space 8;
         shift + lalt - 9 : yabai -m window --space 9;

      shift + ctrl - 1 : yabai -m space --focus 1
      shift + ctrl - 2 : yabai -m space --focus 2
      shift + ctrl - 3 : yabai -m space --focus 3
      shift + ctrl - 4 : yabai -m space --focus 4
      shift + ctrl - 5 : yabai -m space --focus 5
      shift + ctrl - 6 : yabai -m space --focus 6
      shift + ctrl - 7 : yabai -m space --focus 7
      shift + ctrl - 8 : yabai -m space --focus 8
      shift + ctrl - 9 : yabai -m space --focus 9
    '';
  };

  services.yabai = {
    enable = true;
    package = pkgs.yabai;
    config = {
      layout = "bsp";
      auto_balance = "off";
      split_ratio = "0.50";
      window_placement = "second_child";
      window_gap = 6;
      top_padding = 6;
      left_padding = 6;
      right_padding = 6;
      bottom_padding = 40;
      mouse_follows_focus = "on";
      focus_follow_mouse = "off";
    };
  };
}
