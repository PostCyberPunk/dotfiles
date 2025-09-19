#!/bin/bash

# Directory for icons
pc="pcmds"
wmcmd="$pc wm"
term="$pc start term"
rofiDir="$HOME/.config/rofi"

# Note: You can add more options below with the following format:
# ["TITLE"]="link"

# Define menu options as an associative array
declare -A menu_options=(
	#fzf
	["wp WallpaperSwitcher"]="$term -o 0.5 -t 'WallpaperSwitcher' -c flkt_fzf bash $pc wall switcher"
	["cb Clipboard"]="$term -o 0.5 -t \"ClipManager\" -c flkt_fzf bash $pc fuzzy clipboard_manager"
	["nws nvim-workspace"]="$term --class nvim bash $pc fuzzy nvim_workspace"
	#waybar
	["wbo ToggleWaybar"]="$pc bar toggle"
	["wbu Update Waybar"]="$pc bar update"
	["wbr reload Waybar"]="$pc bar reload"
	["wbs WaybarStyles"]="$rofiDir/scripts/WaybarStyles.sh"
	["wbl WaybarLayout"]="$rofiDir/scripts/WaybarLayout.sh"
	#hypr
	["wmr reload windowmanager"]="$wmcmd reload"
	["wma Toggle windowmanager animation"]="$wmcmd toggle_animation"
	["rld reload All"]="$pc system reload"
	["gm GameMode"]="$wmcmd toggle_gamemode"
	["blur ChangeBlur"]="$wmcmd toggle_blur"
	["flt Float all window"]="hyprctl dispatch workspaceopt allfloat"
	["wmop toggle_opaque"]="$wmcmd toggle_opaque"
	["crt toggle_crt_shader"]="$wmcmd toggle_shader crt"
	["nbl toggle_noblue_shader"]="$wmcmd toggle_shader noblue"
	["sw reloadWallpapaer"]="$pc wall reload"
	#rofi
	["; Launcher"]="rofi -show drun -theme $rofiDir/tools/launchpad.rasi"
	["= Calculator"]="rofi -show calc -modi calc -no-show-match -no-sort -theme $rofiDir/tools/calc.rasi"
	["ww WindowSwitcher"]="rofi -show window -modi window calc -theme $rofiDir/tools/long.rasi"
	["rbw bitwarden"]="rofi-rbw"
	["nmc networkmanager"]="$rofiDir/scripts/networkmanager.sh"
	["blt bluetoothctl"]="rofi-bluetooth false -theme ~/.config/rofi/tools/cmd.rasi"
	# ["tr Translation"]="fish -c rofi_trans -theme $rofiDir/tools/cmd.rasi"
	["trs Translation"]="$pc start translate_shell"
	["trc Translation chinese"]="$pc start translate_shell zh:en"
	["trv Translation voice"]="$pc start translate_shell -speak"
	#System
	["QQ Shutdown"]="$pc system ask_poweroff"
	["RR Reboot"]="$pc system ask_reboot"
	["PP powermenu"]="pc system power_menu"
	["ml MonitorLayout"]="$term -t \"MonitorLayout\" -c flkt_fzf bash $pc fuzzy monitor_switcher"
	["gpu GPU Switcher"]="$term -t \"GPU_Switcher\" -c flkt_fzf bash $pc fuzzy gpu_switcher"
	["cn Close Notifactions"]="$pc notify clear"
	["nc  notifactioncenter"]="$pc notify history"
	["ttp ToggleTouchPad"]="$pc device toggle_touchpad"
	["DM0"]="$pc device disable_edp1"
	["DM1"]="$pc device enable_edp1"
	["cl toggle fan mode"]="$pc device toggle_cooler"
	["sdv validate superuser credential"]="$pc system get_su"
	["sdk reset superuser privilege"]="$pc system reset_su"
	#App
	["ff firefox"]="firefox"
	["uu tebrowser"]="qutebrowser"
	["vb VitrualBox"]="virtualbox"
	["vm VitrualBox"]="vboxmanage startvm Larch"
	["v2 v2raya"]="firefox http://localhost:2017/"
	["cls clash"]="clash-verge"
	["sp Spotify"]="spotify"
	["lg Lazygit"]="$term -c flkt3lg lazygit"
	["gL GitLogin"]="$pc start GitLogin"
	["bp1 center template"]="$pc start Center"
	["td todo notes"]="$pc start notes"
	["fum"]="$pc start fum"
	["kew"]="$pc start kew"
	#VR
	["vr0 disable vrboot"]="$pc vrboot 0"
	["vr1 enable vrboot"]="$pc vrboot 1"
	["vncg wayvnc start"]="$pc cmd_wayvnc"
	["vncl wayvnc local"]="$pc cmd_wayvnc 1"
	["vnco wayvnc other output"]="$pc vnc_add_output"
	["vncd wayvnc quit"]="pkill wayvnc"
	["vncm wayvnc switch-output"]="wayvncctl output-cycle"
	["adb forward"]="$pc cmd_adb"
	["vrpo vr enable proximity sensor"]="adb shell am broadcast -a com.oculus.vrpowermanager.automation_disable"
	["vrpf vr disable proximity sensor"]="adb shell am broadcast -a com.oculus.vrpowermanager.prox_close"
	#Utils
	["mnt MountDisk"]="$rofiDir/rofi-usb-mount.sh"
	["cp PickColor(rgb)"]="hyprpicker -f rgb -a"
	["cph PickColor(hex)"]="hyprpicker -f hex -a"
	["ss serach with web"]="$rofiDir/scripts/web-search.sh"
)

# Main function
main() {
	choice=$(
		printf "%s\n" "${!menu_options[@]}" |
			rofi -dmenu -config ~/.config/rofi/tools/cmd.rasi \
				-p "Rofi" \
				-mesg "Hello" \
				-max-history-size 0 \
				-matching normal \
				-auto-select
	)

	if [ -z "$choice" ]; then
		exit 1
	fi

	link="${menu_options[$choice]}"
	$link
}

main
