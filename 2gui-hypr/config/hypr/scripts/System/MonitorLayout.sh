# Define directories
source ~/.config/hypr/lib/system_cmd.sh
config_dir="$HOME/.config/hypr/lib/Monitor"
target_file="$HOME/.config/hypr/configs/Monitors.conf"
after_apply() {
	hyprctl reload
	# restart_waybar_if_needed
	notify-send $1
}
source ~/.config/hypr/lib/applets/linker.sh
