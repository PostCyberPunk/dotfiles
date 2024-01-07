#!/bin/bash

wallpaper_switcher=$HOME/.config/hypr/HyprTools/WallpaerSwitcher.sh
wallpaper_dir=$HOME/Pictures/wallpapers

kitty -T "FTQCW" --class floating bash $wallpaper_switcher "$wallpaper_dir"
