#!/usr/bin/env bash

source "$HOME/.config/sketchybar/variables.sh"

PLAY_COLOR="$GREEN"
PAUSE_COLOR="$DARK_WHITE"

STATE="$(echo "$INFO" | jq -r '.state')"
APP="$(echo "$INFO" | jq -r '.app')"

if [ "$STATE" = "playing" ] && [ "$APP" == "Spotify" ]; then
	MEDIA="$(echo "$INFO" | jq -r '.title + " - " + .artist')"
	sketchybar --set "$NAME" label="$MEDIA" drawing=on icon=󰎆 icon.color="$PLAY_COLOR"
# elif [ "$STATE" = "paused" ] && [ "$APP" == "Spotify" ]; then
# 	MEDIA="$(echo "$INFO" | jq -r '.title + " - " + .artist')"
# 	sketchybar --set "$NAME" label="$MEDIA" drawing=on icon= icon.color="$PAUSE_COLOR" 
else
	sketchybar --set "$NAME" drawing=off
fi
