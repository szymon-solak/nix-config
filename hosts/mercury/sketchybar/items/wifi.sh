sketchybar \
	--add item wifi right \
	--set wifi \
	script="$SCRIPTS_DIR/wifi.sh" \
	icon= \
	label.padding_right=10 \
	icon.padding_left=10 \
	--subscribe wifi wifi_change
