#!/bin/bash

#Apps
term() {
	_term "$@"
}
fum() {
	_state=$(pkill fum || _term -o 0 -c fum -e fum)
	$_state
}
kew() {
	_state=$(pkill kew || _term -o 0 -c flkt7kew -e kew)
	$_state
}
translate_shell() {
	local transtext=$(rofi -theme ~/.config/rofi/tools/inputs.rasi -dmenu)
	if [[ $transtext = "" ]]; then
		transtext=$(wl-paste)
	fi
	_term -c "flkt5" -f 16 fish -C "trans $1 \"$transtext\"|fzf --ansi --reverse --multi|wl-copy"
}
# Presets
Todo() {
	_term -o 0.1 -c flktmini1 peaclock
	sleep 0.1
	_term -c flkt7td -o 0.5 -d ~/notes/ -f 18 -e "nvim -n $HOME/notes/index.norg -c NeoTodo "
}
notes() {
	_term -d ~/notes/ -o 0.5 -f 18 -e "nvim -c Neorg index "
}
Tops() {
	_term -t "fltops-btm" -c flkt6tp btm
}
#FIX: useTerm
Center() {
	if _need_confirm "Template One?"; then
		echo yes
	else
		exit
	fi
	_term -1 &
	sleep 0.1
	layout_center_on
	_set_var 'is_center' 1
	sleep 0.1
	_term -1 fish -C btm &
	sleep 0.1
	_term -1 fish -C "peaclock --config $HOME/.peaclock/timer" &
	sleep 0.1
	_term -1 fish -C lf &
	sleep 0.1
	_term &
	sleep 0.3
	hyprctl --batch "dispatch togglegroup;dispatch resizeactive 0 -90%;dispatch cyclenext"
	sleep 0.1
	_term fish -C nvim &
	sleep 0.5
	hyprctl --batch "dispatch layoutmsg addmaster;dispatch resizeactive 0 -55%"
}
GitLogin() {
	if [[ "$(hyprctl -j activewindow | jq -r -c '.class')" != "firefox" ]]; then
		hyprctl dispatch togglespecialworkspace tempgit
		firefox &
		sleep 1
		while [[ "$(hyprctl -j activewindow | jq -r -c '.class')" != "firefox" ]]; do
			sleep 1
		done
		local __address=$(hyprctl -j activewindow | jq -r -c ".address")
		hyprctl --batch "dispatch togglefloating;dispatch resizeactive exact 50% 50%;dispatch centerwindow"
		sleep 0.1
		hyprctl dispatch togglespecialworkspace tempgit
	fi
	git-credential-manager github login &
	sleep 1
	local _test_count=1
	while [[ "$(git-credential-manager github list)" = "" ]]; do
		if [[ $_test_count -le 30 ]]; then
			sleep 1
			((_test_count++))
		else
			noti_c "Github Login Failed"
			exit 1
		fi
	done
	if [[ ! -z $__address ]]; then
		hyprctl dispatch closewindow address:$__address
	fi
	update_waybar
	_noti_n " Github Login"
}
