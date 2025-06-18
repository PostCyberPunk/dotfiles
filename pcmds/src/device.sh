#!/bin/bash

enable_touchpad_s() {
	_set_var touchpad "0"
	if [[ "$XDG_SESSION_DESKTOP" == "Hyprland" ]]; then
		hyprctl keyword "device[$touchpad_id]:enabled" 1
	else
		sed -i '/touchpad {/!b;n;c\// off' "$niri_config"
	fi
	pkill -RTMIN+3 waybar
}

disable_touchpad_s() {
	_set_var touchpad "1"
	if [[ "$XDG_SESSION_DESKTOP" == "Hyprland" ]]; then
		hyprctl keyword "device[$touchpad_id]:enabled" 0
	else
		sed -i '/touchpad {/!b;n;c\off' "$niri_config"
	fi
	pkill -RTMIN+3 waybar
}

enable_touchpad() {
	enable_touchpad_s
	_noti_n "󰍽 Enabling Touchpad"
}
disable_touchpad() {
	disable_touchpad_s
	_noti_n "󰎀 Disabling Touchpad"
}
toggle_touchpad() {
	mstate=$(_get_var touchpad)
	echo "$mstate"
	if [[ $mstate = "1" ]]; then
		enable_touchpad
	else
		disable_touchpad
	fi
}

temp_touchpad() {
	if [[ $(_get_var touchpad) = "0" ]]; then
		exit
	fi
	enable_touchpad_s
	# _key_pressed=$(keyd monitor | grep -q "esc down")
	_key_pressed=$(keyd monitor | grep -q -E '^keyd.*down')
	disable_touchpad_s
	# if [[ $(grep "f1 down" <<<$_key_pressed) = "" ]]; then
	# 	disable_touchpad
	# else
	# 	_noti_n "Touchpad keep going"
	# fi
	exit
}

toggle_wifi() {
	wifi="$(nmcli r wifi | awk 'FNR = 2 {print $1}')"
	if [ "$wifi" == "enabled" ]; then
		rfkill block all &
		_noti_n '󰀝 airplane mode: active'
	else
		rfkill unblock all &
		_noti_n '󰀞 airplane mode: inactive'
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
		_noti_n " gamemode enabled. All animations off"
		exit
	else
		sleep 0.5
		pcmds system reload
		_noti_n " gamemode disabled. All animations normal"
		swww-daemon &
		sleep 2
		swww img "$HOME/.config/rofi/.current_wallpaper"
		exit
	fi
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
	sudo -nv || {
		_noti_n "󰮯 Privilige needed"
		exit 1
	}
	local var_name="cooler"
	local status=$(_get_var "$var_name")
	if [ "$status" = "1" ]; then
		sudo isw -b on
		_set_var "$var_name" "0"
		_noti_n " ooler:on"
	else
		sudo isw -b off
		_set_var "$var_name" "1"
		_noti_n "󰠝 Cooler:off"
	fi
}
vrboot() {
	# [ -f $vrboot_file ] && _noti_n "1" || _noti_n "0"
	if [[ "$1" = "1" ]]; then
		[ -f $vrboot_file ] || echo "1" >$vrboot_file
		_noti_n " VRBoot enabled"
	else
		[ -f $vrboot_file ] && rm -f $vrboot_file
		_noti_n "󱗧 VRBoot disabled"
	fi
}
cmd_adb() {
	adb reverse tcp:5900 tcp:5900
}
cmd_wayvnc() {
	pkill wayvnc
	if [[ $1 == "1" ]]; then
		wayvnc $(_get_lan_ip) -f 60 &
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
	sunshine &
}
boot_vr() {
	[ -f ~/.cache/vrboot ] && start_vr
}
