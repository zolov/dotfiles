#!/usr/bin/env bash

function get_input_lang() {
    defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources | command rg '"KeyboardLayout Name" = ([^";]*)' --replace '$1' --only-matching --color=never
}

INPUT_SOURCE=$(get_input_lang)

case $INPUT_SOURCE in
  ABC)
    INPUT_SOURCE="EN‣"
    ;;
  RussianWin)
    INPUT_SOURCE="RU‣"
    ;;
  *)
    INPUT_SOURCE="unknown"
    ;;
esac

sketchybar --set "$NAME"         \
            icon=""             \
            label="$INPUT_SOURCE"
