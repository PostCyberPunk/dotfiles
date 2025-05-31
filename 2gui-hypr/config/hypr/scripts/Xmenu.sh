#!/bin/bash

# Directory for icons
RunCMD="$HOME/.config/hypr/scripts/RunCMD.sh"
scriptsDir="$HOME/.config/hypr/scripts"
rofiDir="$HOME/.config/rofi"

# Note: You can add more options below with the following format:
# ["TITLE"]="link"

# Define menu options as an associative array
declare -A menu_options=(
	#fzf
	["wp WallpaperSwitcher"]="kitty -o background_opacity=0.5 -T \"WallpaperSwitcher\" --class flkt_fzf bash $RunCMD wallpaper_switcher"
	["cb Clipboard"]="kitty -o background_opacity=0.5 -T \"ClipManager\" --class flkt_fzf bash $RunCMD clipboard_manager"
	#waybar
	["wbo ToggleWaybar"]="pkill -SIGUSR1 waybar"
	["wbs WaybarStyles"]="$rofiDir/scripts/WaybarStyles.sh"
	["wbl WaybarLayout"]="$rofiDir/scripts/WaybarLayout.sh"
	["wbr reload Waybar"]="$RunCMD reload_waybar"
	["wbu Update Waybar"]="$RunCMD update_waybar"
	#hypr
	["hpr reload hyprland"]="$RunCMD reload_hypr"
	["hpa Toggle hyprland animation"]="$RunCMD toggle_animation"
	["rld reload All"]="$RunCMD reload_all"
	["gm GameMode"]="$RunCMD toggle_gamemode"
	["blur ChangeBlur"]="$RunCMD toggle_blur"
	["flt Float all window"]="hyprctl dispatch workspaceopt allfloat"
	["wop1 enable_opaque"]="$RunCMD enable_opaque"
	["wop0 disable_opaque"]="$RunCMD disable_opaque"
	["crt toggle_crt_shader"]="$RunCMD toggle_shader crt"
	["nbl toggle_noblue_shader"]="$RunCMD toggle_shader noblue"
	["ttp ToggleTouchPad"]="$RunCMD toggle_touchpad"
	["sw reloadWallpapaer"]="$RunCMD reboot_swww"
	#rofi
	["; Launcher"]="rofi -show drun -theme $rofiDir/tools/launchpad.rasi"
	["= Calculator"]="rofi -show calc -modi calc -no-show-match -no-sort -theme $rofiDir/tools/calc.rasi"
	["ww WindowSwitcher"]="rofi -show window -modi window calc -theme $rofiDir/tools/long.rasi"
	["rbw bitwarden"]="rofi-rbw"
	["nmc networkmanager"]="$rofiDir/scripts/networkmanager.sh"
	["blt bluetoothctl"]="rofi-bluetooth false -theme ~/.config/rofi/tools/cmd.rasi"
	# ["tr Translation"]="fish -c rofi_trans -theme $rofiDir/tools/cmd.rasi"
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
	["nc  notifactioncenter"]="swaync-client -t -sw"
	["DM0"]="$RunCMD disable_edp1"
	["DM1"]="$RunCMD enable_edp1"
	["cl toggle fan mode"]="$RunCMD toggle_cooler"
	["sdv validate superuser credential"]="$RunCMD get_su"
	["sdk reset superuser privilege"]="$RunCMD reset_su"
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
	["fum"]="$RunCMD start_fum"
	["kew"]="$RunCMD start_kew"
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
