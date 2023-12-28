scripts_dir="$HOME/.config/hypr/scripts"
#waybar
restart_waybar_if_needed() {
	if pgrep -x "waybar" >/dev/null; then
		pkill waybar
		sleep 0.1 # Delay for Waybar to completely terminate
	fi
	"${scripts_dir}/Refresh.sh" &
}
