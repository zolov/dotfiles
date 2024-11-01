#!/usr/bin/env bash

sketchybar --add event input_source_changed

lang=(
    update_freq=3 
    icon.color="$COLOR" 
    icon.padding_left=10 
    label.padding_right=10 
	icon="🌐"
    label.color="$LABEL_COLOR" 
    background.drawing=on 
    background.height=26 
    background.padding_right=5 
    background.color="$BAR_COLOR" 
    background.border_color="$BORDER" 
    background.border_width="$BORDER_WIDTH" 
    background.corner_radius="$CORNER_RADIUS" 
	plugin="$PLUGIN_DIR/input_language.sh"
)

sketchybar --add item input_language right \
	--set input_language "${lang[@]}"      \
	--subscribe input_language input_source_changed 
