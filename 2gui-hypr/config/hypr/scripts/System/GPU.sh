# Define directories
source ~/.config/hypr/lib/system_cmd.sh
config_dir="$HOME/.config/hypr/lib/GPU"
target_file="$HOME/.config/hypr/configs/GPU.conf"
after_apply() {
	# restart_waybar_if_needed
	hyprctl dispatch forcerendererreload
	hyprctl reload
	notify-send $1
}
source ~/.config/hypr/lib/applets/linker.sh
