#!/usr/bin/env bash

LABEL="$(ipconfig getsummary en0 | awk -F ' SSID : '  '/ SSID : / {print $2}')"

sketchybar --set "$NAME" \
	icon=""             \
	label="$LABEL"
