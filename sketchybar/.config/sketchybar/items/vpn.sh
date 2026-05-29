#!/usr/bin/env bash

COLOR="$BLUE"
LABEL_COLOR="$WHITE"
BORDER="$COMMENT"

vpn=(
	update_freq=10
	icon.color="$COLOR"
	icon.padding_left=10
	icon.padding_right=3
	label.padding_right=10
	label.color="$LABEL_COLOR"
	background.drawing=on
	background.height=26
	background.padding_right=5
	background.color="$BAR_COLOR"
	background.border_color="$BORDER"
	background.border_width="$BORDER_WIDTH"
	background.corner_radius="$CORNER_RADIUS"
	script="$PLUGIN_DIR/vpn.sh"
)

sketchybar --add item vpn right \
	--set vpn "${vpn[@]}"	\
