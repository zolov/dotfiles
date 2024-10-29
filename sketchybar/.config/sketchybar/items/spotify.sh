#!/usr/bin/env bash

COLOR="$GREEN"
BORDER="$COMMENT"

spotify=(
	icon=󰎆 
	updates=on 
	scroll_texts=on 
	icon.color="$COLOR" 
	icon.padding_left=10 
    label.color="$WHITE"
	label.max_chars=23 
	label.padding_right=10 
	associated_display=active 
	background.drawing=on 
	background.height=26 
	background.padding_right=-5 
	background.color="$BAR_COLOR" 
	background.border_color="$BORDER" 
	background.border_width="$BORDER_WIDTH" 
	background.corner_radius="$CORNER_RADIUS" 
	script="$PLUGIN_DIR/spotify.sh" 
)

sketchybar --add item spotify q      \
	--set spotify "${spotify[@]}"    \
	--subscribe spotify media_change
