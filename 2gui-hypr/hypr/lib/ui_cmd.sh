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
		hyprctl dispatch  splitratio exact 0.5
		set_var $varname 1
	fi
}
