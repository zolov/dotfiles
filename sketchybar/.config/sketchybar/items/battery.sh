#!/usr/bin/env bash

COLOR="$SKY"
LABEL_COLOR="$WHITE"
BORDER="$COMMENT"

sketchybar --add item battery right \
	--set battery \
	update_freq=60 \
	icon.color="$COLOR" \
	icon.padding_left=10 \
	label.padding_right=10 \
	label.color="$LABEL_COLOR" \
	background.height=26 \
	background.corner_radius="$CORNER_RADIUS" \
	background.padding_right=5 \
	background.border_width="$BORDER_WIDTH" \
	background.border_color="$BORDER" \
	background.color="$BAR_COLOR" \
	background.drawing=on \
	script="$PLUGIN_DIR/power.sh" \
	--subscribe battery power_source_change
