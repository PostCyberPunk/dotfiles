#!/bin/bash

toggle() {
	pkill -SIGUSR1 waybar
}
update() {
	pkill -RTMIN+4 waybar
	_noti_n "󰑓 Refresh Waybar"
}
reload() {
	_ps=(waybar rofi)
	for _prs in "${_ps[@]}"; do
		if pidof "${_prs}" >/dev/null; then
			pkill "${_prs}"
		fi
	done

	sleep 0.1
	# Relaunch waybar
	waybar &
	_noti_n "󰛺 Reload Waybar"
}
restart() { #notes
	if pgrep -x "waybar" >/dev/null; then
		pkill waybar
		sleep 0.1 # Delay for Waybar to completely terminate
	fi
	reload &
}
