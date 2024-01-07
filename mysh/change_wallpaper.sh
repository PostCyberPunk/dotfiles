#!/bin/bash

# Transition config
FPS=60
TYPE="simple"
DURATION=1
SWWW_PARAMS="--transition-fps $FPS --transition-type $TYPE --transition-duration $DURATION"

function change_wallpaper() {
	swww query || swww init && swww img $1 $SWWW_PARAMS
  ln -sf "$(pwd)/$1" "$HOME/.config/rofi/.current_wallpaper"
}
