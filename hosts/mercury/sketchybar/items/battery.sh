sketchybar \
	--add item battery right \
	--set battery \
	script="$SCRIPTS_DIR/battery.sh" \
	update_freq=120 \
	label.padding_right=10 \
	--subscribe battery system_woke power_source_change
