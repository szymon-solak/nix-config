{ pkgs, ... }: {
  home.packages = [
    pkgs.tofi # TODO: Theme
    pkgs.obs-studio # TODO: Fix screenshare
    pkgs.mako
    pkgs.killall
  ];

  home.file.".config/hypr/hyprland.conf".text = ''
            		monitor=,preferred,auto,auto
            		env = XCURSOR_SIZE,24

								exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
        				exec-once = hyprpaper & mako

    						input {
    								kb_layout = pl,us
    								follow_mouse = 1

    								touchpad {
    										natural_scroll = false
    								}

    								sensitivity = 0 # -1.0 - 1.0, 0 means no modification.

										repeat_delay = 150
										repeat_rate = 30
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

    						$mainMod = SUPER
    						bind = $mainMod, Q, exec, kitty
    						bind = $mainMod, C, killactive
    						bind = $mainMod, M, exit
    						bind = $mainMod, E, exec, nautilus
    						bind = $mainMod, W, exec, firefox
    						bind = $mainMod, V, togglefloating
    						bind = $mainMod, R, exec, tofi-drun
    						bind = $mainMod, P, pseudo
    						bind = $mainMod, J, togglesplit

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
            	'';
}
