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
	#fzf
	["wp WallpaperSwitcher"]="kitty -T \"WallpaperSwitcher\" --class flkt_fzf bash $RunCMD wallpaper_switcher"
	["cb Clipboard"]="kitty -T \"ClipManager\" --class flkt_fzf bash $RunCMD clipboard_manager"
	#waybar
	["wbt ToggleWaybar"]="killall -SIGUSR1 waybar"
	["wbs WaybarStyles"]="$rofiDir/WaybarStyles.sh"
	["wbl WaybarLayout"]="$rofiDir/WaybarLayout.sh"
	["wbr Reload Waybar"]="$RunCMD reload_waybar"
	["wbu Update Waybar"]="$RunCMD update_waybar"
  #hypr
	["hpr Reload hyprland"]="$RunCMD reload_hypr"
	["rld Reload All"]="$RunCMD reload_all"
	["gm GameMode"]="$RunCMD toggle_gamemode"
	["bl ChangeBlur"]="$RunCMD toggle_blur"
	["flt Float all window"]="hyprctl dispatch workspaceopt allfloat"
  #rofi
	["; Launcher"]="rofi -show drun -theme $HOME/.config/rofi/launchers/launcher.rasi"
	["rd RofiBeats"]="$rofiDir/RofiBeats.sh"
	["emj RofiEmoji"]="$rofiDir/RofiEmoji.sh"
	["cc Calculator"]="rofi -modi \"calc:$rofiSH/rofi-calc.sh\" -show calc"
	["fd Finder"]="rofi -modi \"find:$rofiSH/finder.sh\" -show find"
	["tr Translation"]="fish -c rofi_trans"
  #System
	["QQ Shutdown"]="needConfim "poweroff""
	["RR Reboot"]="needConfim "reboot""
	["uw Wlogout"]="$scriptsDir/Wlogout.sh"
	["ml MonitorLayout"]="$scriptsDir/System/MonitorLayout.sh"
	["gpu GPU Switcher"]="$scriptsDir/System/GPU.sh"
	["cn Close Notifactions"]="swaync-client -C"
	["DM0"]="$RunCMD disable_edp1"
	["DM1"]="$RunCMD enable_edp1"
  #App
	["ff firefox"]="firefox"
	["vb VitrualBox"]="virtualbox"
	["vm VitrualBox"]="vboxmanage startvm Larch"
	["v2 v2raya"]="firefox http://localhost:2017/"
	["sp Spotify"]="spotify"
	["lg Lazygit"]="kitty --class flkt3lg lazygit"
  ["p1 center template"]="$RunCMD startCenter"
  ["td todo notes"]="$RunCMD open_notes"
  #Utils
	["mnt MountDisk"]="$rofiSH/rofi-usb-mount.sh"
	["cp PickColor(RGB)"]="hyprpicker -f rgb -a"
	["cph PickColor(hex)"]="hyprpicker -f hex -a"

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
