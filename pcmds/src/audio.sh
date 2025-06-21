#!/bin/bash

_get_icon() {
	current=$(get_volume)
	if [[ "$current" == "Muted" ]]; then
		echo "$icon_dir/volume-mute.png"
	elif [[ "${current%\%}" -le 30 ]]; then
		echo "$icon_dir/volume-low.png"
	elif [[ "${current%\%}" -le 60 ]]; then
		echo "$icon_dir/volume-mid.png"
	else
		echo "$icon_dir/volume-high.png"
	fi
}
# Get Volume
get_volume() {
	volume=$(pamixer --get-volume)
	if [[ "$volume" -eq "0" ]]; then
		echo "Muted"
	else
		echo "$volume%"
	fi
}

# Notify
notify_user() {
	if [[ "$(get_volume)" == "Muted" ]]; then
		notify-send -e -h string:x-canonical-private-synchronous:volume_notif -u low -i "$(_get_icon)" "Volume: Muted"
	else
		notify-send -e -h int:value:"$(get_volume | sed 's/%//')" -h string:x-canonical-private-synchronous:volume_notif -u low -i "$(_get_icon)" "Volume: $(get_volume)"
	fi
}

# Increase Volume
inc_volume() {
	if [ "$(pamixer --get-mute)" == "true" ]; then
		pamixer -u && notify_user
	fi
	pamixer -i 5 && notify_user
}

# Decrease Volume
dec_volume() {
	if [ "$(pamixer --get-mute)" == "true" ]; then
		pamixer -u && notify_user
	fi
	pamixer -d 5 && notify_user
}

# Toggle Mute
toggle_mute() {
	if [ "$(pamixer --get-mute)" == "false" ]; then
		pamixer -m && notify-send -e -u low -i "$icon_dir/volume-mute.png" "Volume Switched OFF"
	elif [ "$(pamixer --get-mute)" == "true" ]; then
		pamixer -u && notify-send -e -u low -i "$(__get_icon)" "Volume Switched ON"
	fi
}

# Toggle Mic
toggle_mic() {
	if [ "$(pamixer --default-source --get-mute)" == "false" ]; then
		pamixer --default-source -m && notify-send -e -u low -i "$icon_dir/microphone-mute.png" "Microphone Switched OFF"
	elif [ "$(pamixer --default-source --get-mute)" == "true" ]; then
		pamixer -u --default-source u && notify-send -e -u low -i "$icon_dir/microphone.png" "Microphone Switched ON"
	fi
}
# Get Mic Icon
get_mic_icon() {
	current=$(pamixer --default-source --get-volume)
	if [[ "$current" -eq "0" ]]; then
		echo "$icon_dir/microphone-mute.png"
	else
		echo "$icon_dir/microphone.png"
	fi
}

# Get Microphone Volume
get_mic_volume() {
	volume=$(pamixer --default-source --get-volume)
	if [[ "$volume" -eq "0" ]]; then
		echo "Muted"
	else
		echo "$volume%"
	fi
}

# Notify for Microphone
notify_mic_user() {
	volume=$(get_mic_volume)
	icon=$(get_mic_icon)
	notify-send -e -h int:value:"$volume" -h "string:x-canonical-private-synchronous:volume_notif" -u low -i "$icon" "Mic-Level: $volume"
}

# Increase MIC Volume
inc_mic() {
	if [ "$(pamixer --default-source --get-mute)" == "true" ]; then
		pamixer --default-source -u && notify_mic_user
	fi
	pamixer --default-source -i 5 && notify_mic_user
}

# Decrease MIC Volume
dec_mic() {
	if [ "$(pamixer --default-source --get-mute)" == "true" ]; then
		pamixer --default-source -u && notify_mic_user
	fi
	pamixer --default-source -d 5 && notify_mic_user
}
