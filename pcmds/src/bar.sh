#!/bin/bash

toggle() {
	pkill -SIGUSR1 waybar
}
update() {
	pkill -RTMIN+4 waybar
	_noti_n "󰑓 Update Waybar"
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
	start
	_noti_n " Reload Waybar"
}
restart() { #notes
	if pgrep -x "waybar" >/dev/null; then
		pkill waybar
		sleep 0.1 # Delay for Waybar to completely terminate
	fi
	reload &
}
start() {
	if [[ "$XDG_SESSION_DESKTOP" == "Hyprland" ]]; then
		waybar &
	else
		systemctl --user start xdg-desktop-portal-gtk
		waybar -c "$XDG_CONFIG_HOME/waybar/configs/1Lapoch-niri.jsonc" &
	fi
}
