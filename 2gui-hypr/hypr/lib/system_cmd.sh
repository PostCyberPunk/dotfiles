source ~/.config/hypr/lib/ref.sh
#waybar
restart_waybar_if_needed() {
	if pgrep -x "waybar" >/dev/null; then
		pkill waybar
		sleep 0.1 # Delay for Waybar to completely terminate
	fi
	"${scripts_dir}/Refresh.sh" &
}
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
