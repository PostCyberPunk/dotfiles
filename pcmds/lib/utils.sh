#!/bin/bash

#vars
_init_var() {
	varfile=$root_cmd_dir/variable.txt
	while read -r line; do
		echo "1" >$var_dir/$line
	done <$varfile
}
_get_var() {
	mval=$(cat $var_dir/$1)
	echo $mval
}
_set_var() {
	echo "$2" >$var_dir/$1
}

#wm
_get_active_workspace() {
	hyprctl monitors -j | jq -r -c '.[]|.activeWorkspace|.name'
}
_get_special_workspace() {
	hyprctl monitors -j | jq -r -c '.[]|.specialWorkspace|.name'
}

#system
_get_lan_ip() {
	$(ip addr show | grep inet | awk '{ print $2 }' | grep '192.168' | cut -d/ -f1 | head -n 1)
}

#ui
_confirm_rofi() {
	rofi -theme $HOME/.config/rofi/tools/confirm.rasi \
		-kb-accept-entry 'Return,space' \
		-selected-row 1 -no-show-match -no-sort \
		-dmenu \
		-mesg "$1"
	# -theme ${dir}/${theme}.rasi
}
_need_confirm() {
	local _result="$(echo -e "$icon_yes\n$icon_no" | _confirm_rofi "$1")"
	if [[ "$_result" == "$icon_yes" ]]; then
		return 0
	else
		return 1
	fi
}

#Notfiy
_noti_n() {
	notify-send -e -t 2000 -u low "$@"
}
noti_c() {
	notify-send -e -u critical "$@"
}
hl_notify() {
	hyprctl notify -1 1000 "rgb(ff1ea3)" "$1"
}
