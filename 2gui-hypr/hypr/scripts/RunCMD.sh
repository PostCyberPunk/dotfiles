source ~/.config/hypr/lib/system_cmd.sh
source ~/.config/hypr/lib/ui_cmd.sh
source ~/.config/hypr/lib/device_cmd.sh

if [[ ! -z "$1" ]]; then
	$1 "${@:2}"
fi
