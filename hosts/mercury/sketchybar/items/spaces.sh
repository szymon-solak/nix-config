SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8" "9" "10")

for i in "${!SPACE_ICONS[@]}"
	do
		sid=$(($i+1))

		sketchybar --add space space.$sid left \
			--set space.$sid associated_space=$sid \
			icon=${SPACE_ICONS[i]} \
			icon.padding_left=14 \
			icon.padding_right=14 \
			padding_left=0 \
			padding_right=0 \
			background.color=0xffbabbf1 \
			background.height=24 \
			background.drawing=off \
			background.corner_radius=5 \
			label.drawing=off \
			script="$SCRIPTS_DIR/space.sh" \
			click_script="yabai -m space --focus $sid"
done

sketchybar --add bracket spaces_bracket '/space\..*/' \
	--set spaces_bracket \
	background.color=0x00000000 \
	background.corner_radius=5 \
	background.height=24
