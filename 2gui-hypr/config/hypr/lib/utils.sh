#!/bin/bash
source ~/.config/hypr/lib/ref.sh

get_active_workspace() {
	hyprctl monitors -j | jq -r -c '.[]|.activeWorkspace|.name'
}
get_special_workspace() {
	hyprctl monitors -j | jq -r -c '.[]|.specialWorkspace|.name'
}
hl_notify() {
	hyprctl notify -1 1000 "rgb(ff1ea3)" "$1"
}
get_lan_ip() {
	lan_ip_add=$(ip addr show | grep inet | awk '{ print $2 }' | grep '192.168' | cut -d/ -f1 | head -n 1)
}
