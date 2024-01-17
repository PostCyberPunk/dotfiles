# Define directories
source ~/.config/hypr/lib/system_cmd.sh
config_dir="$HOME/.config/hypr/lib/Monitor"
target_file="$HOME/.config/hypr/configs/Monitors.conf"
rofi_config="$HOME/.config/rofi/config-long.rasi"
extens=""
after_apply() {
  hyprctl reload
	# restart_waybar_if_needed
	notify-send $1
}
source ~/.config/hypr/lib/applets/linker.sh
# config_dir="$HOME/.config/waybar/style"
# target_file="$HOME/.config/waybar/style.css"
# scripts_dir="$HOME/.config/hypr/scripts"
# rofi_config="$HOME/.config/rofi/config-long.rasi"
# extens=".css"
