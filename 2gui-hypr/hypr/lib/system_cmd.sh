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
	notify-send -e -u low "$1"
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
update_waybar()
{
	pkill -RTMIN+4 waybar
  noti_n "Refresh Waybar"
}
reload_hypr(){
  hyprctl Reload
}
reload_all(){
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
