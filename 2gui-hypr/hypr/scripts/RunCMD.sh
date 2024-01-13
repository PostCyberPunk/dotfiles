#!/bin/bash
source ~/.config/hypr/lib/system_cmd.sh
source ~/.config/hypr/lib/ui_cmd.sh
source ~/.config/hypr/lib/device_cmd.sh
source ~/.config/hypr/lib/fzf_cmd.sh

help() {
  declare -F
}
if [[ ! -z "$1" ]]; then
	$1 "${@:2}"
fi
