#!/usr/bin/env bash

COLOR="$MAUVE"
BORDER="$COMMENT"
LABEL_COLOR="$WHITE"

clock=(
	update_freq=1 
	icon.color="$COLOR" 
	icon.padding_left=10 
	label.width=78 
	label.padding_right=5 
	label.color="$LABEL_COLOR" 
	align=center 
	background.drawing=on 
	background.height=26 
	background.padding_right=2 
	background.color="$BAR_COLOR" 
	background.border_color="$BORDER" 
	background.border_width="$BORDER_WIDTH" 
	background.corner_radius="$CORNER_RADIUS" 
	script="$PLUGIN_DIR/clock.sh"
)

sketchybar --add item clock right \
	--set clock "${clock[@]}"     \
