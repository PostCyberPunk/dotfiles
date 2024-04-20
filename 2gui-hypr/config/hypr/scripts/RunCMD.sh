#!/bin/bash
source ~/.config/hypr/lib/system_cmd.sh
source ~/.config/hypr/lib/ui_cmd.sh
source ~/.config/hypr/lib/device_cmd.sh
source ~/.config/hypr/lib/fzf_cmd.sh

help() {
	declare -F | awk '{print $3}' | grep -v '^_' | tr '\n' '\t' | fold -sw $(tput cols)
}
if [[ ! -z "$1" ]]; then
	$1 "${@:2}"
fi
