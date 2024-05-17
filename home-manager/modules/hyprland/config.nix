{pkgs, ...}: {
  home.packages = [
    pkgs.tofi
    pkgs.obs-studio # TODO: Fix recording
    pkgs.obs-studio-plugins.wlrobs
    pkgs.mako
    pkgs.killall
    pkgs.udiskie
    pkgs.grimblast
    pkgs.wl-clipboard
    pkgs.cliphist
    pkgs.gnome.nautilus
    pkgs.gnome.sushi
    pkgs.imv
  ];

  home.file.".config/mako/config".text = ''
    background-color=#1e1e2e
    text-color=#cdd6f4
    border-color=#89b4fa
    progress-color=over #313244

    [urgency=high]
    border-color=#fab387
  '';

  home.file.".config/hypr/hyprland.conf".text = ''
    exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    exec-once = dbus-update-activation-environment --systemd HYPRLAND_INSTANCE_SIGNATURE
    				exec-once = hyprpaper

        		monitor=,preferred,auto,auto
        		env = XCURSOR_SIZE,24
    env = SSH_ASKPASS_REQUIRE,"prefer"

    exec-once = ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1
    exec-once = mako
    exec-once = waybar
    exec-once = hypridle
    exec-once = wl-paste --type text --watch cliphist store
    exec-once = wl-paste --type image --watch cliphist store
    exec = hyprshade auto

    		input {
    				kb_layout = pl,us
    				follow_mouse = 1

    				touchpad {
    						natural_scroll = false
    				}

    				sensitivity = 0 # -1.0 - 1.0, 0 means no modification.

    		repeat_delay = 150
    		repeat_rate = 50
    		}

    		general {
    				gaps_in = 5
    				gaps_out = 20
    				border_size = 2
    				col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
    				col.inactive_border = rgba(595959aa)

    				layout = dwindle
    		}

    		decoration {
    				rounding = 0
    				drop_shadow = true
    				shadow_range = 4
    				shadow_render_power = 3
    				col.shadow = rgba(1a1a1aee)
    		}

    		animations {
    				enabled = true
    		}

    		dwindle {
    				pseudotile = true
    				preserve_split = true
    		smart_split = false
    		}

    misc {
    	disable_hyprland_logo = true
    }

    		$mainMod = SUPER
    		bind = $mainMod, Q, exec, kitty
    		bind = $mainMod, C, killactive
    		bind = $mainMod, M, exit
    		bind = $mainMod, E, exec, nautilus
    		bind = $mainMod, W, exec, firefox
    		bind = $mainMod, V, togglefloating
    		bind = $mainMod, R, exec, tofi-drun --fuzzy-match=true --prompt-text "can I have " --background-color 181825 --text-color cdd6f4 --selection-color cba6f7 --border-width=2 --border-color cba6f7 --outline-width=0 --corner-radius=10 --font-size 20 | xargs hyprctl dispatch exec -- zsh -c
    		bind = $mainMod, P, pseudo
    		bind = $mainMod, J, togglesplit
    bind = $mainMod, L, exec, hyprlock

    		# Move focus with mainMod + arrow keys
    		bind = $mainMod, left, movefocus, l
    		bind = $mainMod, right, movefocus, r
    		bind = $mainMod, up, movefocus, u
    		bind = $mainMod, down, movefocus, d

    		# Switch workspaces with mainMod + [0-9]
    		bind = $mainMod, 1, workspace, 1
    		bind = $mainMod, 2, workspace, 2
    		bind = $mainMod, 3, workspace, 3
    		bind = $mainMod, 4, workspace, 4
    		bind = $mainMod, 5, workspace, 5
    		bind = $mainMod, 6, workspace, 6
    		bind = $mainMod, 7, workspace, 7
    		bind = $mainMod, 8, workspace, 8
    		bind = $mainMod, 9, workspace, 9
    		bind = $mainMod, 0, workspace, 10

    # Switch to sibling workspace
    bind = CTRL_ALT, left, workspace, -1
    bind = CTRL_ALT, right, workspace, +1

    bind = $mainMod, F, fullscreen, 0

    		# Move active window to a workspace with mainMod + SHIFT + [0-9]
    		bind = $mainMod SHIFT, 1, movetoworkspace, 1
    		bind = $mainMod SHIFT, 2, movetoworkspace, 2
    		bind = $mainMod SHIFT, 3, movetoworkspace, 3
    		bind = $mainMod SHIFT, 4, movetoworkspace, 4
    		bind = $mainMod SHIFT, 5, movetoworkspace, 5
    		bind = $mainMod SHIFT, 6, movetoworkspace, 6
    		bind = $mainMod SHIFT, 7, movetoworkspace, 7
    		bind = $mainMod SHIFT, 8, movetoworkspace, 8
    		bind = $mainMod SHIFT, 9, movetoworkspace, 9
    		bind = $mainMod SHIFT, 0, movetoworkspace, 10

    		# Scroll through existing workspaces with mainMod + scroll
    		bind = $mainMod, mouse_down, workspace, e+1
    		bind = $mainMod, mouse_up, workspace, e-1

    		# Move/resize windows with mainMod + LMB/RMB and dragging
    		bindm = $mainMod, mouse:272, movewindow
    		bindm = $mainMod, mouse:273, resizewindow

    # Screenshots
    bind = $mainMod, p, exec, grimblast save active
    bind = $mainMod SHIFT, p, exec, grimblast save area
    bind = $mainMod ALT, p, exec, grimblast save output
    bind = $mainMod CTRL, p, exec, grimblast save screen
  '';
}
