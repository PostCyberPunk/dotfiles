#!/bin/bash
source ~/.config/hypr/lib/ref.sh
source ~/.config/hypr/lib/system_cmd.sh

toggle_split_ratio() {
	varname="split_ratio"
	if [[ -z $1 ]]; then
		mmax=0.7
		mmin=0.5
	else
		mmax="$1"
		mmin="$2"
	fi
	mstate=$(get_var $varname)
	if [[ $mstate = "1" ]]; then
		hyprctl dispatch splitratio exact $mmax
		set_var $varname 0
	else
		hyprctl dispatch splitratio exact $mmin
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

toggle_animation() {
	STATE=$(hyprctl -j getoption animations:enabled | jq ".int")
	if [ "${STATE}" = "1" ]; then
		hyprctl keyword animations:enabled 0
		noti_n "Disable animation"
	else
		hyprctl keyword animations:enabled 1
		noti_n "Enable animation"
	fi

}
enable_opaque() {
	sleep 0.2
	hyprctl setprop address:$(hyprctl -j activewindow | jq -r -c ".address") forceopaque 0 lock
}
disable_opaque() {
	sleep 0.2
	hyprctl setprop address:$(hyprctl -j activewindow | jq -r -c ".address") forceopaque 1 lock
}

_link_wallpaper() {
	ln -sf "$PWD/$1" "$wallpaper_cache"
}
change_wallpaper() {
	if [[ -f $1 ]]; then
		mv -f "$wallpaper_cache" "$wallpaper_cache-bak"
		_link_wallpaper $1 || mv -f "$wallpaper_cache-bak" "$wallpaper_cache"
	fi
	swww query || swww-daemon && swww img $1 $SWWW_PARAMS
}
reboot_swww() {
	swww kill
	sleep 1
	swww-daemon &
}

change_layout() {
	LAYOUT=$(hyprctl -j getoption general:layout | jq '.str' | sed 's/"//g')

	case $LAYOUT in
	"master")
		layout_dwindle
		;;
	"dwindle")
		layout_master
		;;
	*) ;;

	esac
}
layout_master() {
	hyprctl --batch "keyword general:layout master;\
		        keyword unbind SUPER, D;\
		        keyword unbind SUPER Alt, D;\
		        keyword bind SUPER, D, layoutmsg, addmaster;\
		        keyword bind SUPER ALT, D, layoutmsg, removemaster"
	noti_n "Master Layout"
}
layout_dwindle() {
	hyprctl --batch "keyword general:layout dwindle;\
		        keyword unbind SUPER, D;\
		        keyword unbind SUPER Alt, D;\
		        keyword bind SUPER, D, layoutmsg, togglesplit;\
		        keyword bind SUPER ALT, D, layoutmsg, pseudo"
	noti_n "Dwindle Layout"
}
layout_center_on() {
	hyprctl --batch "\
  keyword unbind SUPER,M;\
  dispatch layoutmsg orientationcenter"
	hyprctl keyword bind SUPER, M,exec,bash ~/.config/hypr/scripts/RunCMD.sh toggle_split_ratio 0.35 0.5
	noti_n "Center Master Layout"
}
layout_center_off() {
	hyprctl --batch "\
  keyword unbind SUPER,M;\
  dispatch layoutmsg orientationright"
	hyprctl keyword bind SUPER, M,exec,bash ~/.config/hypr/scripts/RunCMD.sh toggle_split_ratio
	noti_n "Right Master Layout"
}
toggle_layout_center() {
	varname="is_center"
	mstate=$(get_var $varname)
	if [[ $mstate = "1" ]]; then
		layout_center_off
		set_var $varname 0
	else
		layout_center_on
		set_var $varname 1
	fi
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
_flkt_dum() {
	kitty --class flktdum fish -c "sleep 0.1&&echo todo" &
}
startTodo() {
	_flkt_dum
	# sleep 0.1
	kitty --class flktmini1 peaclock &
	sleep 0.1
	kitty --class flkt7td -d ~/notes/ -o font_family='CaskaydiaCove Nerd Font Mono' -o font_size=18 nvim -n ~/notes/index.norg -c 'NeoTodo' &
	# kitty -T "fltd-clock" --class flkt2t peaclock &
	# kitty -T "fltd-Todo" --class flkt5td quest-tui &
}
open_notes() {
	kitty -d ~/notes/ -o font_family='CaskaydiaCove Nerd Font Mono' -o font_size=18 nvim -c 'Neorg index' &
}
startTops() {
	_flkt_dum
	kitty -T "fltops-btm" --class flkt6tp btm &
	# kitty btm &
}
startFLKT() {
	_flkt_dum
	kitty --class $1 $2 &
}
startCenter() {
	if _need_confirm "Template One?"; then
		echo yes
	else
		exit
	fi
	kitty -1 &
	sleep 0.1
	layout_center_on
	set_var 'is_center' 1
	sleep 0.1
	kitty -1 fish -C btm &
	sleep 0.1
	kitty -1 fish -C "peaclock --config $HOME/.peaclock/timer" &
	sleep 0.1
	kitty -1 fish -C lf &
	sleep 0.1
	kitty &
	sleep 0.3
	hyprctl --batch "dispatch togglegroup;dispatch resizeactive 0 -90%;dispatch cyclenext"
	sleep 0.1
	kitty fish -C nvim &
	sleep 0.5
	hyprctl --batch "dispatch layoutmsg addmaster;dispatch resizeactive 0 -55%"
}
close_special() {
	local result=$(hyprctl monitors | rg 'special:')
	if [[ $result != "" ]]; then
		local __name=$(awk -F'l:' '{print $2}' <<<$result | awk -F')' '{print $1}')
		hyprctl dispatch togglespecialworkspace "$__name"
	fi
}
startGitLogin() {
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
	noti_n "Github Login"
}
drop_special() {
	local spw=$(get_special_workspace)
	if [[ $spw != "" ]]; then
		hyprctl dispatch movetoworkspace $(get_active_workspace)
	else
		hyprctl dispatch movetoworkspacesilent special:$1
	fi
}
grab_special() {
	hyprctl dispatch togglespecialworkspace $1
	sleep 0.2
	easyfocus-hyprland
	hyprctl dispatch movetoworkspace $(get_active_workspace)
}
