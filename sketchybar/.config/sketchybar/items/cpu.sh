#!/usr/bin/env bash

COLOR="$YELLOW"
LABEL_COLOR="$WHITE"
BORDER="$COMMENT"

sketchybar --add item cpu right \
	--set cpu \
	update_freq=5 \
	icon.color="$COLOR" \
	icon.padding_left=10 \
	label.color="$LABEL_COLOR" \
	label.padding_right=10 \
	background.height=26 \
	background.corner_radius="$CORNER_RADIUS" \
	background.padding_right=5 \
	background.border_width="$BORDER_WIDTH" \
	background.border_color="$BORDER" \
	background.color="$BAR_COLOR" \
	background.drawing=on \
	script="$PLUGIN_DIR/cpu.sh"
