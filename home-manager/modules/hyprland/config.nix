{pkgs, ...}: {
  home.packages = [
    pkgs.killall
    pkgs.udiskie
    pkgs.grimblast
    pkgs.adwaita-icon-theme
    pkgs.bibata-cursors
    pkgs.nautilus
    pkgs.sushi
    pkgs.imv
    pkgs.hyprshot
  ];

  services.mako.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    settings = {
      monitor = ",preferred,auto,auto";

      env = [
        "SSH_ASKPASS_REQUIRE,prefer"
        "XCURSOR_THEME,Bibata-Modern-Ice"
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_THEME,Bibata-Modern-Ice"
        "HYPRCURSOR_SIZE,24"
      ];

      exec-once = [
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
        "hyprshade auto"
      ];

      input = {
        kb_layout = "pl,us";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = false;
        };
        sensitivity = 0;
        repeat_delay = 150;
        repeat_rate = 50;
      };

      general = {
        gaps_in = 5;
        gaps_out = "8, 8, 8, 8";
        border_size = 2;
        layout = "dwindle";
      };

      decoration = {
        rounding = 6;
        active_opacity = 1.0;
        inactive_opacity = 0.95;
      };

      animations = {
        enabled = true;
        bezier = "easeOutExpo, 0.16, 1, 0.3, 1";

        animation = [
          "windows, 1, 2, easeOutExpo, slide"
          "windowsOut, 1, 2, easeOutExpo, slide"
          "border, 1, 6, easeOutExpo"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
        smart_split = true;
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };

      windowrulev2 = [
        "idleinhibit always, class:^(vlc)"
        "size 1000 700, title:^(Select one or more files to open), initialClass:^(vlc)$"
      ];

      "$mainMod" = "SUPER";

      bind = [
        "$mainMod, Q, exec, kitty"
        "$mainMod, C, killactive"
        "$mainMod, M, exit"
        "$mainMod, E, exec, nautilus"
        "$mainMod, W, exec, firefox"
        "$mainMod, V, togglefloating"
        "$mainMod, R, exec, tofi-drun"
        # "$mainMod, R, exec, tofi-run | xargs hyprctl dispatch exec"
        "$mainMod, B, exec, dmenu-bluetooth --connected-icon 󰂱"
        "$mainMod, P, pseudo"
        "$mainMod, J, togglesplit"
        "$mainMod, L, exec, hyprlock"
        "$mainMod SHIFT, Q, exec, wlogout --buttons-per-row=1"

        # Move focus with mainMod + arrow keys
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Switch to sibling workspace
        "CTRL_ALT, left, workspace, -1"
        "CTRL_ALT, right, workspace, +1"

        "$mainMod, F, fullscreen, 0"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        # Screenshots
        "$mainMod, p, exec, hyprshot -m region --clipboard-only"
        "$mainMod SHIFT, p, exec, hyprshot -m window"
        "$mainMod ALT, p, exec, hyprshot -m output"
      ];

      bindm = [
        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };
}
