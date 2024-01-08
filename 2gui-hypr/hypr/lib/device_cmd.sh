source ~/.config/hypr/lib/ref.sh
source ~/.config/hypr/lib/system_cmd.sh

enable_touchpad() {
	notify-send -e -u low "Enabling Touchpad"
	set_var touchpad "0"
	hyprctl keyword "device:$touchpad_id:enabled" true
}

disable_touchpad() {
	notify-send -e -u low "Disabling Touchpad"
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
