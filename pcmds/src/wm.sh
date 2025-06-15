#!/bin/bash
###########General
reload() {
	hyprctl reload
	_noti_n " Reload Hyprland"
}

###########Decoration
toggle_blur() {
	STATE=$(hyprctl -j getoption decoration:blur:passes | jq ".int")

	if [ "${STATE}" == "2" ]; then
		hyprctl keyword decoration:blur:size 5
		hyprctl keyword decoration:blur:passes 1
		_noti_n "  Less blur"
	else
		hyprctl keyword decoration:blur:size 12
		hyprctl keyword decoration:blur:passes 2
		_noti_n "  Normal blur"
	fi
}
toggle_animation() {
	STATE=$(hyprctl -j getoption animations:enabled | jq ".int")
	if [ "${STATE}" = "1" ]; then
		hyprctl keyword animations:enabled 0
		_noti_n " Disable animation"
	else
		hyprctl keyword animations:enabled 1
		_noti_n "󱏰 Enable animation"
	fi

}
toggle_opaque() {
	sleep 0.2
	hyprctl dispatch setprop active opaque toggle
}
toggle_shader() {
	_target="$XDG_CONFIG_HOME/hypr/configs/Shader.conf"
	if [[ $(readlink "$_target") == "/dev/null" ]]; then
		ln -sf "$XDG_CONFIG_HOME/hypr/lib/shader/$1.conf" "$_target"
	else
		ln -sf "/dev/null" "$_target"
	fi
	reload
}

###########Layout
toggle_split_ratio() {
	varname="split_ratio"
	if [[ -z $1 ]]; then
		mmax=0.7
		mmin=0.5
	else
		mmax="$1"
		mmin="$2"
	fi
	mstate=$(_get_var $varname)
	if [[ $mstate = "1" ]]; then
		hyprctl dispatch splitratio exact $mmax
		_set_var $varname 0
	else
		hyprctl dispatch splitratio exact $mmin
		_set_var $varname 1
	fi
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
	_noti_n "  Master Layout"
}
layout_dwindle() {
	hyprctl --batch "keyword general:layout dwindle;\
		        keyword unbind SUPER, D;\
		        keyword unbind SUPER Alt, D;\
		        keyword bind SUPER, D, layoutmsg, togglesplit;\
		        keyword bind SUPER ALT, D, layoutmsg, pseudo"
	_noti_n "  Dwindle Layout"
}
layout_center_on() {
	hyprctl --batch "\
  keyword unbind SUPER,M;\
  dispatch layoutmsg orientationcenter"
	hyprctl keyword bind SUPER, M,exec,pcmds wm toggle_split_ratio 0.35 0.5
	_noti_n "  Center Master Layout"
}
layout_center_off() {
	hyprctl --batch "\
  keyword unbind SUPER,M;\
  dispatch layoutmsg orientationright"
	hyprctl keyword bind SUPER, M,exec,pcmds wm toggle_split_ratio
	_noti_n "  Right Master Layout"
}
toggle_layout_center() {
	varname="is_center"
	mstate=$(_get_var $varname)
	if [[ $mstate = "1" ]]; then
		layout_center_on
		_set_var $varname 0
	else
		layout_center_off
		_set_var $varname 1
	fi
}
###########  WORKSPACE
close_special() {
	local result=$(hyprctl monitors | rg 'special:')
	if [[ $result != "" ]]; then
		local __name=$(awk -F'l:' '{print $2}' <<<$result | awk -F')' '{print $1}')
		hyprctl dispatch togglespecialworkspace "$__name"
	fi
}
drop_special() {
	local spw=$(_get_special_workspace)
	if [[ $spw != "" ]]; then
		hyprctl dispatch movetoworkspace $(_get_active_workspace)
	else
		hyprctl dispatch movetoworkspacesilent special:$1
	fi
}
grab_special() {
	hyprctl dispatch togglespecialworkspace $1
	sleep 0.2
	easyfocus-hyprland
	hyprctl dispatch movetoworkspace $(_get_active_workspace)
}

######niri-only

enable_center_always() {
	sed -i '/center-focused-column/c\center-focused-column "always"' "$niri_config"
	_noti_n " Always center"
}
disable_center_always() {
	sed -i '/center-focused-column/c\center-focused-column "never"' "$niri_config"
	_noti_n " Nerver center"
}
toggle_center_always() {
	_word=$(rg center-focused-column "$niri_config" | choose 1)
	if [[ -z "$_word" ]]; then
		ehco "no center found"
		exit 1
	fi
	if [[ "$_word" == '"never"' ]]; then
		enable_center_always
	else
		disable_center_always
	fi
	exit
}
