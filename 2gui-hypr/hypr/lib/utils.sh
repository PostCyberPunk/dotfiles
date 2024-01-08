#!/bin/bash
get_active_workspace() {
	return $(hyprctl -j clients | jq -c '.id')
}
hl_notify() {
	hyprctl notify -1 1000 "rgb(ff1ea3)" "$1"
}
