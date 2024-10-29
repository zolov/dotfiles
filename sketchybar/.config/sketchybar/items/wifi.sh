#!/usr/bin/env bash

COLOR="$SAPPHIRE"
BORDER="$COMMENT"
LABEL_COLOR="$WHITE"

wifi=(
	update_freq=10 
	icon.color="$COLOR" 
	icon.padding_left=10 
	label.padding_right=10 
	label.color="$LABEL_COLOR"
	background.drawing=on 
	background.height=26 
	background.padding_right=5 
	background.color="$BAR_COLOR"
	background.border_color="$BORDER"
	background.border_width="$BORDER_WIDTH"
	background.corner_radius="$CORNER_RADIUS"
	script="$PLUGIN_DIR/wifi.sh"
)

sketchybar --add item wifi right \
		--set wifi "${wifi[@]}"  \
