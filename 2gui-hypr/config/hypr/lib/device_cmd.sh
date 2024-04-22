#!/bin/bash
source ~/.config/hypr/lib/ref.sh
source ~/.config/hypr/lib/system_cmd.sh

enable_touchpad_s() {
	set_var touchpad "0"
	hyprctl keyword "device[$touchpad_id]:enabled" 1
	pkill -RTMIN+3 waybar
}

disable_touchpad_s() {
	set_var touchpad "1"
	hyprctl keyword "device[$touchpad_id]:enabled" 0
	pkill -RTMIN+3 waybar
}

enable_touchpad() {
	noti_n "Enabling Touchpad"
	enable_touchpad_s
}
disable_touchpad() {
	noti_n "Disabling Touchpad"
	disable_touchpad_s
}
toggle_touchpad() {
	mstate=$(get_var touchpad)
	echo "$mstate"
	if [[ $mstate = "1" ]]; then
		enable_touchpad
	else
		disable_touchpad
	fi
}

temp_touchpad() {
	if [[ $(get_var touchpad) = "0" ]]; then
		exit
	fi
	enable_touchpad_s
	# _key_pressed=$(keyd monitor | grep -q "esc down")
	_key_pressed=$(keyd monitor | grep -q -E '^keyd.*down')
	disable_touchpad_s
	# if [[ $(grep "f1 down" <<<$_key_pressed) = "" ]]; then
	# 	disable_touchpad
	# else
	# 	noti_n "Touchpad keep going"
	# fi
	exit
}

toggle_wifi() {
	wifi="$(nmcli r wifi | awk 'FNR = 2 {print $1}')"
	if [ "$wifi" == "enabled" ]; then
		rfkill block all &
		noti_n 'airplane mode: active'
	else
		rfkill unblock all &
		noti_n 'airplane mode: inactive'
	fi
}

toggle_gamemode() {
	HYPRGAMEMODE=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')
	if [ "$HYPRGAMEMODE" = "1" ]; then
		hyprctl --batch "\
        keyword animations:enabled 0;\
        keyword decoration:drop_shadow 0;\
        keyword decoration:blur:passes 0;\
        keyword general:gaps_in 0;\
        keyword general:gaps_out 0;\
        keyword general:border_size 1;\
        keyword decoration:rounding 0"
		# keyword decoration:active_opacity 1;\
		# keyword decoration:inactive_opacity 1;\
		swww kill
		noti_n "gamemode enabled. All animations off"
		exit
	else
		sleep 0.5
		reload_waybar
		reload_hypr
		noti_n "gamemode disabled. All animations normal"
		swww-daemon &
		sleep 2
		swww img "$HOME/.config/rofi/.current_wallpaper"
		exit
	fi
	hyprctl reload
}
restore_gpu() {
	ln -sf "$HOME/.config/hypr/lib/GPU/1Default.conf" "$HOME/.config/hypr/configs/GPU.conf"
	ln -sf "$HOME/.config/hypr/lib/Monitor/1Default.conf" "$HOME/.config/hypr/configs/Monitors.conf"
}
disable_edp1() {
	enable_edp1
	sleep 1
	hyprctl keyword monitor eDP-1,disable
}
enable_edp1() {
	hyprctl keyword monitor eDP-1,preferred,auto,1
}
toggle_cooler() {
	local var_name="cooler"
	local status=$(get_var "$var_name")
	if [ "$status" = "1" ]; then
		sudo isw -b on
		set_var "$var_name" "0"
		noti_n "Cooler:on"
	else
		sudo isw -b off
		set_var "$var_name" "1"
		noti_n "Cooler:off"
	fi
}
vrboot() {
	# [ -f $vrboot_file ] && noti_n "1" || noti_n "0"
	if [[ "$1" = "1" ]]; then
		[ -f $vrboot_file] || echo "1" >$vrboot_file
		noti_n "VRBoot enabled"
	else
		[ -f $vrboot_file ] && rm -f $vrboot_file
		noti_n "VRBoot disabled"
	fi
}
cmd_adb() {
	adb reverse tcp:5900 tcp:5900
}
cmd_wayvnc() {
	pkill wayvnc
	if [[ $1 == "1" ]]; then
		get_lan_ip
		wayvnc $lan_ip_add -f 60 &
	else
		wayvnc -f 60 &
	fi
}
vnc_add_output() {
	hyprctl output create headless
	sleep 1
	wayvnc 127.0.0.1 5902 -f 60 -S /tmp/wvnc2 &
	adb reverse tcp:5902 tcp:5902
}
start_vr() {
	# hyprctl dispatch workspace 2
	# hyprctl output create headless
	cmd_wayvnc
	cmd_adb
	swww kill
	sleep 1
	swww-daemon &
}
boot_vr() {
	[ -f ~/.cache/vrboot ] && start_vr
}
