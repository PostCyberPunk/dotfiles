#!/bin/bash
var_dir=~/.cache/pcp_hypr_var
rofi_dir=$HOME/.config/rofi

touchpad_id="cust0001:00-06cb:cdad-touchpad"
wallpaper_dir=$HOME/Pictures/wallpapers
wallpaper_cache=$HOME/.config/rofi/.current_wallpaper

gpu_src_dir="$HOME/.config/hypr/lib/GPU"
gpu_target_file="$HOME/.config/hypr/configs/GPU.conf"
monitor_src_dir="$HOME/.config/hypr/lib/Monitor"
monitor_target_file="$HOME/.config/hypr/configs/Monitors.conf"
vrboot_file=~/.cache/vrboot

SWWW_FPS=60
SWWW_TYPE="simple"
SWWW_DURATION=0.5
SWWW_PARAMS="--transition-fps $SWWW_FPS --transition-type $SWWW_TYPE --transition-duration $SWWW_DURATION --transition-step 12"

backlight_step="10%"
kbd_backlight_step="25%"

icon_dir="$HOME/.config/swaync/icons"
icon_yes=" "
icon_no=" "
cursor_size=24
