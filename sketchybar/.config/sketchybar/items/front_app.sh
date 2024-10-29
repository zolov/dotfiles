#!/usr/bin/env bash

COLOR="$WHITE"
BORDER="$COMMENT"

front_app=(
    update_freq=1
    icon.drawing=off
	label.color="$COLOR"
	label.padding_left=10
	label.padding_right=10
	associated_display=active
    background.height=26
    background.padding_left=0
    background.padding_right=10
	background.color="$BAR_COLOR"
    background.border_color="$BORDER"
	background.border_width="$BORDER_WIDTH"
    background.corner_radius="$CORNER_RADIUS"
    script="$PLUGIN_DIR/front_app.sh"
)

sketchybar --add item front_app left         \
	--set front_app "${front_app[@]}"        \
	--subscribe front_app front_app_switched
