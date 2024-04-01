{ pkgs, ... }:
let fonts = pkgs.nerdfonts.override { fonts = [ "Iosevka" ]; };
in
{
  home.packages = [
    pkgs.tofi # TODO: Theme
    pkgs.hyprpaper
    pkgs.obs-studio
    pkgs.mako
    pkgs.killall
  ];

  home.file.".config/hypr/hyprpaper.conf".text =
    "	preload = ~/Pictures/wallpaper.jpg\n	wallpaper = WL-1,~/Pictures/wallpaper.jpg\n";

  home.file.".config/hypr/hyprland.conf".text = ''
        		monitor=,preferred,auto,auto
        		env = XCURSOR_SIZE,24

    				exec-once = hyprpaper & mako

						input {
								kb_layout = pl,us
								kb_variant =
								kb_model =
								kb_options =
								kb_rules =

								follow_mouse = 1

								touchpad {
										natural_scroll = false
								}

								sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
						}

						general {
								gaps_in = 5
								gaps_out = 20
								border_size = 2
								col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
								col.inactive_border = rgba(595959aa)

								layout = dwindle

								# Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
								# allow_tearing = false
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
								bezier = myBezier, 0.05, 0.9, 0.1, 1.05
								animation = windows, 1, 7, myBezier
								animation = windowsOut, 1, 7, default, popin 80%
								animation = border, 1, 10, default
								animation = borderangle, 1, 8, default
								animation = fade, 1, 7, default
								animation = workspaces, 1, 6, default
						}

						dwindle {
								# See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
								pseudotile = true # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
								preserve_split = true # you probably want this
						}

						$mainMod = SUPER
						bind = $mainMod, Q, exec, kitty
						bind = $mainMod, C, killactive,
						bind = $mainMod, M, exit,
						bind = $mainMod, E, exec, nautilus
						bind = $mainMod, F, exec, firefox
						bind = $mainMod, V, togglefloating,
						bind = $mainMod, R, exec, tofi-drun --font ${fonts}/share/fonts/truetype/NerdFonts/IosevkaNerdFontMono-Light.ttf
						bind = $mainMod, P, pseudo, # dwindle
						bind = $mainMod, J, togglesplit, # dwindle

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

						# Example special workspace (scratchpad)
						bind = $mainMod, S, togglespecialworkspace, magic
						bind = $mainMod SHIFT, S, movetoworkspace, special:magic

						# Scroll through existing workspaces with mainMod + scroll
						bind = $mainMod, mouse_down, workspace, e+1
						bind = $mainMod, mouse_up, workspace, e-1

						# Move/resize windows with mainMod + LMB/RMB and dragging
						bindm = $mainMod, mouse:272, movewindow
						bindm = $mainMod, mouse:273, resizewindow
        	'';

  # wayland.windowManager.hyprland = {
  #   enable = true;
  #   extraConfig = ''
  #     			# exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
  #     			# exec-once = systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
  #
  #     			# exec-once = killall xdg-desktop-portal-hyprland && killall xdg-desktop-portal-wlr && killall xdg-desktop-portal && ${pkgs.xdg-desktop-portal-hyprland}/libexec/xdg-desktop-portal-hyprland
  #     			# exec-once = ${pkgs.xdg-desktop-portal}/libexec/xdg-desktop-portal
  #           		'';
  # };
}
