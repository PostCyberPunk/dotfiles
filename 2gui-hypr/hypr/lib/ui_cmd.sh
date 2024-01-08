source ~/.config/hypr/lib/ref.sh
source ~/.config/hypr/lib/system_cmd.sh
toggle_split_ratio() {
	varname="split_ratio"
	mstate=$(get_var $varname)
	if [[ $mstate = "1" ]]; then
		hyprctl dispatch splitratio exact 0.7
		echo "1"
		set_var $varname 0
	else
		echo "2"
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
change_wallpaper() {
	ln -sf "$(pwd)/$1" "$HOME/.config/rofi/.current_wallpaper"
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
	result=$(hyprctl -j clients | jq -c '.[] | select(.initialTitle == "FTQCT") | .pid')
	if [[ -z $result ]]; then
		kitty -T "FTQCT" --class floating &
		exit 0
	else
		hyprctl dispatch togglespecialworkspace FTQCT
	fi
}
