#!/bin/bash

# Directory for icons
iDIR="$HOME/.config/swaync/icons"
RunCMD="$HOME/.config/hypr/scripts/RunCMD.sh"
scriptsDir="$HOME/.config/hypr/scripts"
rofiDir="$HOME/.config/rofi/scripts"

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
	["hpa Toggle hyprland animation"]="$RunCMD toggle_animation"
	["rld Reload All"]="$RunCMD reload_all"
	["gm GameMode"]="$RunCMD toggle_gamemode"
	["blur ChangeBlur"]="$RunCMD toggle_blur"
	["flt Float all window"]="hyprctl dispatch workspaceopt allfloat"
	["wop1 enable_opaque"]="$RunCMD enable_opaque"
	["wop0 disable_opaque"]="$RunCMD disable_opaque"
	["ttp ToggleTouchPad"]="$RunCMD toggle_touchpad"
	["sww reboot"]="$RunCMD reboot_swww"
	#rofi
	["; Launcher"]="rofi -show drun -theme $HOME/.config/rofi/launchers/launcher.rasi"
	["rd RofiBeats"]="$rofiDir/RofiBeats.sh"
	["emj RofiEmoji"]="$rofiDir/RofiEmoji.sh"
	["cc Calculator"]="rofi -modi \"calc:$rofiDir/rofi-calc.sh\" -show calc -theme $HOME/.config/rofi/config-long.rasi"
	["fd Finder"]="rofi -modi \"find:$rofiDir/finder.sh\" -show find -theme $HOME/.config/rofi/config-long.rasi"
	# ["tr Translation"]="fish -c rofi_trans -theme $HOME/.config/rofi/config-long.rasi"
	["trs Translation"]="$RunCMD translate_shell"
	["trc Translation chinese"]="$RunCMD translate_shell zh:en"
	["trv Translation voice"]="$RunCMD translate_shell -speak"
	#System
	["QQ Shutdown"]="$RunCMD sys_poweroff"
	["RR Reboot"]="$RunCMD sys_reboot"
	["SS Wlogout"]="$scriptsDir/System/Wlogout.sh"
	["ml MonitorLayout"]="kitty -T \"MonitorLayout\" --class flkt_fzf bash $RunCMD monitor_switcher"
	["gpu GPU Switcher"]="kitty -T \"GPU_Switcher\" --class flkt_fzf bash $RunCMD gpu_switcher"
	["cn Close Notifactions"]="swaync-client -C"
	["DM0"]="$RunCMD disable_edp1"
	["DM1"]="$RunCMD enable_edp1"
	["cl toggle fan mode"]="$RunCMD toggle_cooler"
	#App
	["ff firefox"]="firefox"
	["vb VitrualBox"]="virtualbox"
	["vm VitrualBox"]="vboxmanage startvm Larch"
	["v2 v2raya"]="firefox http://localhost:2017/"
	["cls clash"]="clash-verge"
	["sp Spotify"]="spotify"
	["lg Lazygit"]="kitty --class flkt3lg lazygit"
	["gL GitLogin"]="$RunCMD startGitLogin"
	["bp1 center template"]="$RunCMD startCenter"
	["td todo notes"]="$RunCMD open_notes"
	#VR
	["vr0 disable vrboot"]="$RunCMD vrboot 0"
	["vr1 enable vrboot"]="$RunCMD vrboot 1"
	["vncg wayvnc start"]="$RunCMD cmd_wayvnc"
	["vncl wayvnc local"]="$RunCMD cmd_wayvnc 1"
	["vnco wayvnc other output"]="$RunCMD vnc_add_output"
	["vncd wayvnc quit"]="pkill wayvnc"
	["vncm wayvnc switch-output"]="wayvncctl output-cycle"
	["adb forward"]="$RunCMD cmd_adb"
	["vrpo vr enable proximity sensor"]="adb shell am broadcast -a com.oculus.vrpowermanager.automation_disable"
	["vrpf vr disable proximity sensor"]="adb shell am broadcast -a com.oculus.vrpowermanager.prox_close"
	#Utils
	["mnt MountDisk"]="$rofiDir/rofi-usb-mount.sh"
	["cp PickColor(RGB)"]="hyprpicker -f rgb -a"
	["cph PickColor(hex)"]="hyprpicker -f hex -a"
)

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
}

main
