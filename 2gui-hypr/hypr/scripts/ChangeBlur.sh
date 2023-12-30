#!/bin/bash

notify_icon="$HOME/.config/swaync/images/bell.png"

STATE=$(hyprctl -j getoption decoration:blur:passes | jq ".int")

if [ "${STATE}" == "2" ]; then
	hyprctl keyword decoration:blur:size 2
	hyprctl keyword decoration:blur:passes 1
  notify-send -e -u low -i "$notify_icon" "Less blur"
else
	hyprctl keyword decoration:blur:size 5
	hyprctl keyword decoration:blur:passes 2
  notify-send -e -u low -i "$notify_icon" "Normal blur"
fi
