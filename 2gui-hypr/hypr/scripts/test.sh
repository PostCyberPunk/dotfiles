# Define directories
source ~/.config/hypr/lib/funcs.sh
config_dir="$HOME/.config/waybar/configs"
target_file="$HOME/.config/waybar/config"
rofi_config="$HOME/.config/rofi/config-long.rasi"
extens=""
after_apply() {
	# echo "done"
	# restart_waybar_if_needed
	notify-send $0
}
source ~/.config/hypr/lib/applets/linker.sh
