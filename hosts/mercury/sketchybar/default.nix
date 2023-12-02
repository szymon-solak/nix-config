{ pkgs, ... }:
let scripts = ./scripts;
in {
  services.sketchybar = {
    enable = true;
    package = pkgs.sketchybar;
    config = ''
      				sketchybar --bar height=32 \
      												 position=bottom \
      												 shadow=on \
      												 color=0x15ffffff

      				# Defaults
      					sketchybar --default icon.font="Iosevka Nerd Font:17.0"  \
                           icon.color=0xffffffff                 \
                           label.font="Iosevka Nerd Font:14.0" \
                           label.color=0xffffffff                \
                           padding_left=5                        \
                           padding_right=5                       \
                           label.padding_left=4                  \
                           label.padding_right=4                 \
                           icon.padding_left=4                   \
                           icon.padding_right=4

      				# Spaces
      				SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8" "9" "10")

      				for i in "''${!SPACE_ICONS[@]}"
      				do
      					sid=$(($i+1))
      					sketchybar --add space space.$sid left                                 \
      										 --set space.$sid associated_space=$sid                      \
      																			icon=''${SPACE_ICONS[i]}                     \
      																			icon.padding_left=15 \
      																			icon.padding_right=15 \
      																			padding_left=1 \
      																			padding_right=1 \
      																			background.color=0x44ffffff                \
      																			background.height=24                       \
      																			background.drawing=off                     \
      																			background.corner_radius=5 \
      																			label.drawing=off                          \
      																			script="${scripts}/space.sh"              \
      																			click_script="yabai -m space --focus $sid"
      				done

      				sketchybar --add bracket spaces_bracket '/space\..*/'  \
                 --set spaces_bracket background.color=0x44050505 background.corner_radius=5


      				# Left
      				sketchybar --add item space_separator left                         \
                 --set space_separator icon=                            \
                                       padding_left=10                   \
                                       padding_right=10                  \
                                       label.drawing=off                 \
                                                                         \
                 --add item front_app left                               \
                 --set front_app       script="${scripts}/front_app.sh" \
                                       icon.drawing=off                  \
                 --subscribe front_app front_app_switched

      				# Right
      				sketchybar --add item clock right                      \
                 --set clock   update_freq=10                        \
                               icon=                                \
                               script="${scripts}/clock.sh"         \
                                                                     \
                 --add item battery right                            \
                 --set battery script=${scripts}/battery.sh           \
                               update_freq=120                       \
                 --subscribe battery system_woke power_source_change \
      																															 \
                 --add item wifi right                               \
                 --set wifi    script="${scripts}/wifi.sh"          \
                               icon=                                \
                 --subscribe wifi wifi_change                        \

      				sketchybar --update
      			'';
  };
}
