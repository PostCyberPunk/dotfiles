# Define directories
source ~/.config/hypr/lib/funcs.sh
config_dir="$HOME/.config/hypr/lib/GPU"
target_file="$HOME/.config/hypr/configs/GPU.conf"
rofi_config="$HOME/.config/rofi/config-long.rasi"
extens=""
after_apply() {
	# restart_waybar_if_needed
	hyprctl dispatch forcerendererreload
	notify-send $0
}
source ~/.config/hypr/lib/applets/linker.sh
# config_dir="$HOME/.config/waybar/style"
# target_file="$HOME/.config/waybar/style.css"
# scripts_dir="$HOME/.config/hypr/scripts"
# rofi_config="$HOME/.config/rofi/config-long.rasi"
# extens=".css"
