#!/usr/bin/env bash

LABEL=$(date '+%H:%M:%S')
sketchybar --set "$NAME" \
		icon=""		 \
		label="$LABEL"
