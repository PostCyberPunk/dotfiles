#!/usr/bin/env bash
## Credit Postcybepunk

# Options
shutdown=' 󱙝 '
reboot='  '
lock='  '
logout='  '

uptime="$(uptime | awk '{print $1}')"
host=$(hostname)

open_rofi() {
	rofi -theme "$HOME/.config/rofi/tools/powermenu.rasi" \
		-kb-accept-entry 'Return,space' \
		-p "$host" \
		-mesg "Uptime: $uptime" \
		-no-show-match -no-sort \
		-dmenu
}

open_menu() {
	echo -e "$reboot\n$shutdown\n$logout\n$lock" | open_rofi
}

chosen="$(open_menu)"
case ${chosen} in
"$shutdown")
	pcmds system ask_poweroff
	;;
"$reboot")
	pcmds system ask_reboot
	;;
"$lock")
	pcmds system ask_lock
	;;
"$logout")
	pcmds system ask_logout
	;;
esac
