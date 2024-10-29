#!/usr/bin/env bash

COLOR="$TEAL"
LABEL_COLOR="$WHITE"
BORDER="$COMMENT"

battery=(
	update_freq=60 
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
	script="$PLUGIN_DIR/power.sh" 
)

sketchybar --add item battery right         \
	--set battery "${battery[@]}"			\
	--subscribe battery power_source_change
