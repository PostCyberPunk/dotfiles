#!/bin/bash
source ~/.config/hypr/lib/ref.sh
source ~/.config/hypr/lib/utils.sh
#waybar
init_var() {
	varfile=~/.config/hypr/lib/variable.txt
	while read -r line; do
		echo "1" >$var_dir/$line
	done <$varfile
}
get_var() {
	mval=$(cat $var_dir/$1)
	echo $mval
}
set_var() {
	echo "$2" >$var_dir/$1
}

noti_n() {
	notify-send -e -t 2000 -u low "$1"
}

noti_c() {
	notify-send -e -u critical "$1"
}

_confirm_rofi() {
	rofi -theme $HOME/.config/rofi/tools/confirm.rasi \
		-kb-accept-entry 'Return,space' \
		-selected-row 1 -no-show-match -no-sort \
		-dmenu \
		-mesg "$1"
	# -theme ${dir}/${theme}.rasi
}
_need_confirm() {
	local _result="$(echo -e "Yes\nNo" | _confirm_rofi "$1")"
	if [[ "$_result" == "Yes" ]]; then
		return 0
	else
		return 1
	fi
}
sys_reboot() {
	if _need_confirm "Reboot system?"; then
		reboot
	fi
}
sys_poweroff() {
	if _need_confirm "Shutdown system?"; then
		poweroff
	fi
}
power_menu() {
	"$rofi_dir/scripts/logout.sh"
}

reload_waybar() {
	_ps=(waybar rofi)
	for _prs in "${_ps[@]}"; do
		if pidof "${_prs}" >/dev/null; then
			pkill "${_prs}"
		fi
	done

	sleep 0.1
	# Relaunch waybar
	if [[ -z $1 ]]; then
		waybar &
	fi
	noti_n "Reload Waybar"
}
update_waybar() {
	pkill -RTMIN+4 waybar
	noti_n "Refresh Waybar"
}
reload_hypr() {
	hyprctl reload
	noti_n "Reload Hyprland"
}
reload_all() {
	reload_hypr
	reload_waybar
}

restart_waybar_if_needed() {
	if pgrep -x "waybar" >/dev/null; then
		pkill waybar
		sleep 0.1 # Delay for Waybar to completely terminate
	fi
	reload_waybar &
}

lock_screen() {
	LOCKCONFIG="$HOME/.config/swaylock/config"
	sleep 0.5s
	swaylock --config ${LOCKCONFIG} &
	disown
}
get_su() {
	kitty -o background_opacity=0.8 --class flkt5 -e sudo -v
	sudo -nv
	if sudo -nv; then
		noti_n "Superuser Auth Succeed"
	else
		noti_c "Superuser Auth Failed"
	fi
}
reset_su() {
	sudo -k && noti_n "Superuser Privilege Reset"
}
