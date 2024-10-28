#!/usr/bin/env bash

sketchybar --set "$NAME" icon="" label="$(ipconfig getsummary en0 | awk -F ' SSID : '  '/ SSID : / {print $2}')"
