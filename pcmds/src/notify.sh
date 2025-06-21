#!/bin/sh
#NOTIFY
info() {
	_noti_n "$@"
}
warn() {
	noti_c "  $@"
}
clear() {
	swaync-client -C
}
history() {
	swaync-client -t -sw
}
