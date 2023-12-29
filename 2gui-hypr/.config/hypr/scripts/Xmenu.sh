#!/bin/bash

# Directory for icons
iDIR="$HOME/.config/dunst/icons"
rofiSH="$HOME/.config/rofi/scripts"
scriptsDir="$HOME/.config/hypr/scripts"
yes='Yes'
no='No'
# Note: You can add more options below with the following format:
# ["TITLE"]="link"

# Define menu options as an associative array
declare -A menu_options=(
	["nv Neovim"]="fish -c nvim"
	["bm Bottom"]="fish -c btm"
	["emj RofiEmoji"]="$scriptsDir/RofiEmoji.sh"
	["wp WallpaperSelect"]="$scriptsDir/WallpaperSelect.sh"
	["wb ToggleWaybar"]="killall -SIGUSR1 waybar"
	["wbs WaybarStyles"]="$scriptsDir/WaybarStyles.sh"
	["wbl WaybarStyles"]="$scriptsDir/WaybarLayout.sh"
	["gm GameMode"]="$scriptsDir/GameMode.sh"
	["rd RofiBeats"]="$scriptsDir/RofiBeats.sh"
	["blur ChangeBlur"]="$scriptsDir/ChangeBlur.sh"
	["tr Translation"]="fish -c rofi_trans"
	["uu PowerOff"]="needConfim "poweroff""
	["ur Reboot"]="needConfim "reboot""
	["uw Wlogout"]="$scriptsDir/Wlogout.sh"
	["rfs Refesh All"]="$scriptsDir/Refresh.sh "
	["cc Calculator"]="rofi -modi \"calc:$rofiSH/rofi-calc.sh\" -show calc"
	["fd Finder"]="rofi -modi \"find:$rofiSH/finder.sh\" -show find"
	["cp PickColor(RGB)"]="hyprpicker -f rgb -a"
	["cph PickColor(RGB)"]="hyprpicker -f hex -a"
	["flt Float all window"]="hyprctl dispatch workspaceopt allfloat"
	["mnt MountDisk"]="$rofiSH/rofi-usb-mount.sh"
	["qe QuickEdit"]="$scriptsDir/QuickEdit.sh "
	["; Launcher"]="rofi -show drun -theme $HOME/.config/rofi/launchers/launcher.rasi"
	["ff firefox"]="firefox"
	["fz FuzzyFind"]="kitty fzf -e"
	["v2 v2raya"]="firefox http://localhost:2017/"
	["sp Spotify"]="spotify"
	["ml MonitorLayout"]="$scriptsDir/MonitorLayout.sh"
	["gpu GPU Switcher"]="$scriptsDir/GPU.sh"
)

# Function for displaying notifications
notification() {
	# dunstify -u normal -i "$iDIR/palette.png" "CMD: $@"
	notify-send "$@"
}

confirm_cmd() {
	rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 250px;}' \
		-theme-str 'mainbox {children: [ "message", "listview" ];}' \
		-theme-str 'listview {columns: 2; lines: 1;}' \
		-theme-str 'element-text {horizontal-align: 0.5;}' \
		-theme-str 'textbox {horizontal-align: 0.5;}' \
		-dmenu \
		-p 'Confirmation' \
		-mesg 'Are you Sure?'
	# -theme ${dir}/${theme}.rasi
}

# Ask for confirmation
confirm_exit() {
	echo -e "$no\n$yes" | confirm_cmd
}
needConfim() {
	selected="$(confirm_exit)"
	if [[ "$selected" == "$yes" ]]; then
		$1
	fi
}
# myt="$(notification number)"
# Main function
main() {
	choice=$(
		printf "%s\n" "${!menu_options[@]}" |
			rofi -dmenu -config ~/.config/rofi/config-long.rasi \
				-p "Rofi" \
				-mesg "Hello" \
				-no-sort \
				""
	)

	if [ -z "$choice" ]; then
		exit 1
	fi

	link="${menu_options[$choice]}"
	$link
	# notification "$choice"
	# test_cmd
}

main
