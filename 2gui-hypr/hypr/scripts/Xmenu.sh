#!/bin/bash

# Directory for icons
iDIR="$HOME/.config/swaync/icons"
rofiSH="$HOME/.config/rofi/scripts"
RunCMD="$HOME/.config/hypr/scripts/RunCMD.sh"
scriptsDir="$HOME/.config/hypr/scripts"
rofiDir="$scriptsDir/Rofi"
yes='Yes'
no='No'
# Note: You can add more options below with the following format:
# ["TITLE"]="link"

# Define menu options as an associative array
declare -A menu_options=(
	["nv Neovim"]="fish -c nvim"
	["bm Bottom"]="fish -c btm"
	["emj RofiEmoji"]="$rofiDir/RofiEmoji.sh"
	["wp WallpaperSelect"]="kitty -T FTQCW --class floatingkitty bash $RunCMD wallpaper_switcher"
	["wbt ToggleWaybar"]="killall -SIGUSR1 waybar"
	["wbs WaybarStyles"]="$rofiDir/WaybarStyles.sh"
	["wbl WaybarLayout"]="$rofiDir/WaybarLayout.sh"
	["wbr Reload Waybar"]="$RunCMD reload_waybar"
	["wbu Update Waybar"]="$RunCMD update_waybar"
  ["rld Reload All"]="$RunCMD reload_all"
	["gm GameMode"]="$RunCMD toggle_gamemode"
	["rd RofiBeats"]="$rofiDir/RofiBeats.sh"
	["blur ChangeBlur"]="$RunCMD toggle_blur"
	["tr Translation"]="fish -c rofi_trans"
	["QQ Shutdown"]="needConfim "poweroff""
	["RR Reboot"]="needConfim "reboot""
	["uw Wlogout"]="$scriptsDir/Wlogout.sh"
	["cc Calculator"]="rofi -modi \"calc:$rofiSH/rofi-calc.sh\" -show calc"
	["fd Finder"]="rofi -modi \"find:$rofiSH/finder.sh\" -show find"
	["cb Clipborad"]="kitty -T \"FTQCW\" --class floatingkitty bash $RunCMD clipboard_manager"
	["cp PickColor(RGB)"]="hyprpicker -f rgb -a"
	["cph PickColor(RGB)"]="hyprpicker -f hex -a"
	["flt Float all window"]="hyprctl dispatch workspaceopt allfloat"
	["mnt MountDisk"]="$rofiSH/rofi-usb-mount.sh"
	["; Launcher"]="rofi -show drun -theme $HOME/.config/rofi/launchers/launcher.rasi"
	["ff firefox"]="firefox"
	["vb VitrualBox"]="virtualbox"
	["vm VitrualBox"]="vboxmanage startvm Larch"
	["fz FuzzyFind"]="kitty fzf -e"
	["v2 v2raya"]="firefox http://localhost:2017/"
	["sp Spotify"]="spotify"
	["ml MonitorLayout"]="$scriptsDir/System/MonitorLayout.sh"
	["gpu GPU Switcher"]="$scriptsDir/System/GPU.sh"

)

# Function for displaying notifications
notification() {
	notify-send -e -u low "$@"
}

confirm_cmd() {
	rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 250px;}' \
		-theme-str 'mainbox {children: [ "message", "listview" ];}' \
		-theme-str 'listview {columns: 2; lines: 1;}' \
		-theme-str 'element-text {horizontal-align: 0.5;}' \
		-theme-str 'textbox {horizontal-align: 0.5;}' \
    -kb-accept-entry 'Return,space' \
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
				-max-history-size 0 \
				-auto-select
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
