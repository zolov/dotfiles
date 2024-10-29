#!/usr/bin/env bash

spacer1=(
	width=10
	icon.drawing=off 
	label.drawing=off 
	background.drawing=off 
)

sketchybar --add item spacer.1 left \
	--set spacer.1 "${spacer1[@]}"  \

for i in {0..9}; do
	sid=$((i + 1))
	sketchybar --add space space.$sid left     \
		--set space.$sid associated_space=$sid \
		label.drawing=off                      \
		icon.padding_left=10                   \
		icon.padding_right=10                  \
		background.padding_left=-5             \
		background.padding_right=-5            \
		script="$PLUGIN_DIR/space.sh"
done

spacer2=(
	width=5
	icon.drawing=off
	label.drawing=off
	background.drawing=off
)

sketchybar --add item spacer.2 left \
	--set spacer.2 "${spacer2[@]}"  \

spaces=(
	background.height=26 
	background.drawing=on
	background.color="$BAR_COLOR" 
	background.border_color="$COMMENT" 
	background.border_width="$BORDER_WIDTH" 
	background.corner_radius="$CORNER_RADIUS" 
)

sketchybar --add bracket spaces '/space.*/' \
	--set spaces "${spaces[@]}"             \

separator=(
    icon=
	icon.color="$COMMENT"
	icon.font="$FONT:Regular:16.0" 
	label.drawing=off 
	background.padding_left=26 
	background.padding_right=15 
	associated_display=active 
)

sketchybar --add item separator left            \
	--set separator separator "${separator[@]}" \
