#!/bin/bash

# A bash script designed to run only once dotfiles installed

# THIS SCRIPT CAN BE DELETED ONCE SUCCESSFULLY BOOTED!! And also, edit ~/.config/hypr/configs/Execs.conf
# not necessary to do since this script is only designed to run only once as long as the marker exists

# Variables
scriptsDir=$HOME/.config/hypr/scripts
wallpaper=$HOME/Pictures/wallpapers/0ParchMan.png
RunCMD=$HOME/.config/hypr/scripts/RunCMD.sh

swww="swww img"

# Check if a marker file exists.
if [ ! -f ~/.config/hypr/.initial_startup_done ]; then

	swww init || swww query && $swww "$wallpaper"

	# Refreshing waybar, dunst, rofi etc.
	# initiate GTK dark mode and apply icon and cursor theme
	# gsettings set org.gnome.desktop.interface gtk-theme Catppuccin-mocha-Standard-Mauve-Dark > /dev/null 2>&1 &
	# gsettings set org.gnome.desktop.interface icon-theme Catppuccin-Mocha > /dev/null 2>&1 &
	# gsettings set org.gnome.desktop.interface cursor-theme Catppuccin-Mocha-Mauve-Cursors > /dev/null 2>&1 &
	# gsettings set org.gnome.desktop.interface cursor-size 24 > /dev/null 2>&1 &
  nwg-look -x
  nwg-look -a
	$RunCMD reload_waybar>/dev/null 2>&1 &
	# initiate the kb_layout (for some reason) waybar cant launch it
	"$scriptsDir/System/SwitchKeyboardLayout.sh" >/dev/null 2>&1 &

	# Create a marker file to indicate that the script has been executed.
	touch ~/.config/hypr/.initial_startup_done
  mkdir -p ~/.cache/pcp_hypr_var
	exit
fi
