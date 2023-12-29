#!/bin/bash

# NOTE: find the right device using hyprctl devices
# notify-send "Boot"
# hyprctl keyword "device:cust0001:00-06cb:cdad-touchpad:enabled" false
HYPRLAND_DEVICE="cust0001:00-06cb:cdad-touchpad"
hyprctl keyword "device:$HYPRLAND_DEVICE:enabled" false
