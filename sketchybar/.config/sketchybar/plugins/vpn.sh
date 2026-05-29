#!/usr/bin/env bash

VPN="$(scutil --nc list | grep 'Connected' | sed -E 's/.*"(.*)".*/\1/')"

if [[ "$VPN" != ""  ]]; then
    sketchybar --set "$NAME" drawing=on icon=􁅏  label="On"
else
    sketchybar --set "$NAME" drawing=on icon=􁣡  label="Off"
	# sketchybar --set "$NAME" drawing=off
fi
