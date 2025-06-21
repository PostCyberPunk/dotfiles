#!/bin/bash

_get_icon() {
	if [ "$current" -le "20" ]; then
		icon="$iDIR/brightness-20.png"
	elif [ "$current" -le "40" ]; then
		icon="$iDIR/brightness-40.png"
	elif [ "$current" -le "60" ]; then
		icon="$iDIR/brightness-60.png"
	elif [ "$current" -le "80" ]; then
		icon="$iDIR/brightness-80.png"
	else
		icon="$iDIR/brightness-100.png"
	fi
}
_notify_bl() {
	notify-send -e -h string:x-canonical-private-synchronous:brightness_notif -h int:value:$current -u low -i "$icon" "$bl_title : $current%"
}
#screen backlight
get_backlight() {
	echo $(brightnessctl -m | cut -d, -f4)
}
change_backlight() {
	current=$(get_backlight | sed 's/%//')
	_get_icon
	bl_title="Brightness"
	echo "$1"
	brightnessctl set "$1" && _notify_bl
}
inc_backlight() {
	change_backlight "+$backlight_step"
}
dec_backlight() {
	change_backlight "$backlight_step-"
}
#keyboardBacklight
get_kbd_backlight() {
	echo $(brightnessctl -d '*::kbd_backlight' -m | cut -d, -f4)
}
# FIX: work but ...
change_kbd_backlight() {
	# current=$(get_kbd_backlight | sed 's/%//')
	_get_icon
	bl_title="Keyboard Brightness"
	# brightnessctl -d *::kbd_backlight set "$1" && _notify_bl
}
inc_kbd_backlight() {
	change_kbd_backlight "+$kbd_backlight_step"
}
dec_kdb_backlight() {
	change_kbd_backlight "$kbd_backlight_step-"
}
