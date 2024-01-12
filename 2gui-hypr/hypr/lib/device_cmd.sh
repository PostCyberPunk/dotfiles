#!/bin/bash
source ~/.config/hypr/lib/ref.sh
source ~/.config/hypr/lib/system_cmd.sh

enable_touchpad() {
	noti_n "Enabling Touchpad"
	set_var touchpad "0"
	hyprctl keyword "device:$touchpad_id:enabled" true
}

disable_touchpad() {
	noti_n "Disabling Touchpad"
	set_var touchpad "1"
	hyprctl keyword "device:$touchpad_id:enabled" false
}

toggle_touchpad() {
	mstate=$(get_var touchpad)
	echo "$mstate"
	if [[ $mstate = "1" ]]; then
		enable_touchpad
	else
		disable_touchpad
	fi
	pkill -RTMIN+3 waybar
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
	HYPRGAMEMODE=$(hyprctl getoption animations:enabled | awk 'NR==2{print $2}')
	if [ "$HYPRGAMEMODE" = 1 ]; then
		hyprctl --batch "\
        keyword animations:enabled 0;\
        keyword decoration:drop_shadow 0;\
        keyword decoration:blur:passes 0;\
        keyword general:gaps_in 0;\
        keyword general:gaps_out 0;\
        keyword general:border_size 1;\
        keyword decoration:rounding 0"
		# swww kill
		noti_n "gamemode enabled. All animations off"
		exit
	else
		swww init && swww img "$HOME/.config/rofi/.current_wallpaper"
		sleep 0.5
		reload_waybar
		noti_n "gamemode disabled. All animations normal"
		exit
	fi
	hyprctl reload
}
restore_gpu(){
	ln -sf "$HOME/.config/hypr/lib/GPU/1 Default.conf" "$HOME/.config/hypr/configs/GPU.conf"
	ln -sf "$HOME/.config/hypr/lib/Monitor/1 Default.conf" "$HOME/.config/hypr/configs/Monitors.conf"
}
disable_edp1(){
  hyprctl keyword monitor eDP-1,preferred,auto,1
  sleep 1
  hyprctl keyword monitor eDP-1,disable
}
