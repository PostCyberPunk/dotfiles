#!/bin/bash

#power
poweroff() {
	# _noti_n " goodbye"
	# sleep 1
	systemctl poweroff
}
reboot() {
	# _noti_n " CU"
	# sleep 1
	systemctl reboot
}
lock() {
	_noti_n "󱙜 Lock not implemented"
}
logout() {
	hyprctl dispatch exit 0
}

ask_reboot() {
	if _need_confirm "Reboot system?"; then
		reboot
	fi
}
ask_poweroff() {
	if _need_confirm "Shutdown system?"; then
		poweroff
	fi
}
ask_logout() {
	if _need_confirm "Logout Session?"; then
		logout
	fi
}
ask_lock() {
	if _need_confirm "Logout Screen?"; then
		lock
	fi
	# LOCKCONFIG="$HOME/.config/swaylock/config"
	# sleep 0.5s
	# swaylock --config ${LOCKCONFIG} &
	# disown
}
power_menu() {
	"$rofi_dir/scripts/powermenu.sh"
}

#sudo
get_su() {
	_term -o 0.8 -c flkt5 -e sudo -v
	sudo -nv
	if sudo -nv; then
		_noti_n "󰮯 Superuser Auth Succeed"
	else
		noti_c " Superuser Auth Failed"
	fi
}
reset_su() {
	sudo -k && _noti_n "󱙜 Superuser Privilege Reset"
}

#UI?
reload() {
	reload_hypr
	reload_waybar
	if [ "$1" == "all" ]; then
		pcmds wall reload
		pcmds rofi close
	fi
}

startup() {
	_startup >"$XDG_CACHE_HOME/p_boot.txt" 2>"$XDG_CACHE_HOME/p_boot_err.txt"
}
_startup() {
	echo 0
	systemctl --user start hyprpolkitagent
	echo 1
	wl-paste --type text --watch cliphist store &
	echo 2
	wl-paste --type image --watch cliphist store &
	echo 3
	fcitx5 -dr
	echo 4
	swww-daemon &
	echo 5
	nm-applet --indicator &
	echo 6
	waybar &
	exit
}
