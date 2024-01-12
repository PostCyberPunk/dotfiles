#!/bin/bash
source ~/.config/hypr/lib/ref.sh
source ~/.config/hypr/lib/system_cmd.sh

toggle_split_ratio() {
	varname="split_ratio"
	mstate=$(get_var $varname)
	if [[ $mstate = "1" ]]; then
		hyprctl dispatch splitratio exact 0.7
		set_var $varname 0
	else
		hyprctl dispatch splitratio exact 0.5
		set_var $varname 1
	fi
}

toggle_blur() {
	STATE=$(hyprctl -j getoption decoration:blur:passes | jq ".int")

	if [ "${STATE}" == "2" ]; then
		hyprctl keyword decoration:blur:size 5
		hyprctl keyword decoration:blur:passes 1
		noti_n "Less blur"
	else
		hyprctl keyword decoration:blur:size 12
		hyprctl keyword decoration:blur:passes 2
		noti_n "Normal blur"
	fi
}

_link_wallpaper() {
	ln -sf "$PWD/$1" "$wallpaper_cache"
}
change_wallpaper() {
	if [[ -f $1 ]]; then
		mv -f "$wallpaper_cache" "$wallpaper_cache-bak"
		_link_wallpaper $1 || mv -f "$wallpaper_cache-bak" "$wallpaper_cache"
	fi
	swww query || swww init && swww img $1 $SWWW_PARAMS
}

change_layout() {
	LAYOUT=$(hyprctl -j getoption general:layout | jq '.str' | sed 's/"//g')

	case $LAYOUT in
	"master")
		hyprctl keyword general:layout dwindle
		hyprctl keyword unbind SUPER, D
		hyprctl keyword unbind SUPER Alt, D
		hyprctl keyword bind SUPER, D, layoutmsg, togglesplit
		hyprctl keyword bind SUPER ALT, D, layoutmsg, pseudo
		noti_n "Dwindle Layout"
		;;
	"dwindle")
		hyprctl keyword general:layout master
		hyprctl keyword unbind SUPER, D
		hyprctl keyword unbind SUPER Alt, D
		hyprctl keyword bind SUPER, D, layoutmsg, addmaster
		hyprctl keyword bind SUPER ALT, D, layoutmsg, removemaster
		noti_n "Master Layout"
		;;
	*) ;;

	esac
}

toggle_term() {
	tname="FTQCT$1"
	result=$(hyprctl -j clients | jq -c ".[] | select(.initialTitle == \"$tname\") | .pid")
	focused=$(hyprctl -j clients | jq -c ".[] | select(.initialTitle == \"$tname\") | .focusHistoryID")
	if [[ -z $result ]]; then
		kitty -T $tname --class floatingkitty $2 &
		exit 0
	else
		hyprctl dispatch pin pid:$result
		if [[ $focused -eq 0 ]]; then
			hyprctl dispatch movetoworkspacesilent special:FTQCT
		else
			hyprctl dispatch focuswindow pid:$result
		fi
		# hyprctl dispatch togglespecialworkspace FTQCT
	fi
}
toggle_term_sp() {
	tname="FTQCS$1"
	result=$(hyprctl -j clients | jq -c ".[] | select(.initialTitle == \"$tname\") | .pid")
	if [[ -z $result ]]; then
		kitty -T $tname --class floatingkitty $2 &
		exit 0
	else
		hyprctl dispatch togglespecialworkspace $tname
	fi
}
open_term_sp() {
	tname="FTQCS$1"
	result=$(hyprctl -j clients | jq -c ".[] | select(.initialTitle == \"$tname\") | .pid")
	if [[ -z $result ]]; then
		kitty -T "FTQCS$1" --class floatingkitty $2 &
	fi
}
startTodo() {
	kitty --class flktmini1 peaclock &
	sleep 0.1
	kitty --class flkt5td quest-tui &
	# kitty -T "fltd-clock" --class flkt2t peaclock &
	# kitty -T "fltd-Todo" --class flkt5td quest-tui &
}
startTops() {
	kitty -T "fltops-btm" --class flkt6tp btm &
}
