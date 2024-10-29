#!/usr/bin/env bash

LABEL="$(ps -A -o %cpu | awk '{s+=$1} END {s /= 8} END {printf "%.1f%%\n", s}')"
sketchybar --set "$NAME" \
        icon=""         \
        label="$LABEL"   \
