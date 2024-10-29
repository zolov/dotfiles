#!/usr/bin/env bash

COLOR="$GREEN"
BORDER="$COMMENT"
LABEL_COLOR="$WHITE"

calendar=(
	update_freq=15 
	icon.color="$COLOR" 
	icon.padding_left=10 
	label.padding_right=10 
	label.color="$LABEL_COLOR" 
	background.drawing=on 
	background.height=26 
	background.padding_right=5 
	background.border_width="$BORDER_WIDTH" 
	background.border_color="$BORDER" 
	background.color="$BAR_COLOR" 
	background.corner_radius="$CORNER_RADIUS" 
	script="$PLUGIN_DIR/calendar.sh"
)

sketchybar --add item calendar right \
	--set calendar "${calendar[@]}"  \
