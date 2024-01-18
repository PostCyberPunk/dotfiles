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
startTodo() {
	kitty --class flktmini1 peaclock &
	sleep 0.1
	kitty --class flkt7td -d ~/notes/ -o font_family='CaskaydiaCove Nerd Font Mono' -o font_size=18 nvim -n ~/notes/index.norg -c 'NeoTodo' &
	# kitty -T "fltd-clock" --class flkt2t peaclock &
	# kitty -T "fltd-Todo" --class flkt5td quest-tui &
}
open_notes(){
	kitty -d ~/notes/ -o font_family='CaskaydiaCove Nerd Font Mono' -o font_size=18 nvim  -c 'Neorg index' &
}
startTops() {
	kitty -T "fltops-btm" --class flkt6tp btm &
}
startCenter() {
	layout_center_on
	set_var 'is_center' 1
	sleep 0.5
	kitty -1 fish -C zellij &
	sleep 0.1
	kitty -1 fish -C btm &
	sleep 0.1
	kitty -1 fish -C 'peaclock --config ~/dotfiles/2gui-hypr/peaclock/timer' &
	sleep 0.1
	kitty -1 fish -C lf &
	sleep 0.1
	kitty &
	sleep 0.3
	hyprctl --batch "dispatch togglegroup;dispatch resizeactive 0 -90%;dispatch cyclenext"
	sleep 0.1
	kitty fish -C n &
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
