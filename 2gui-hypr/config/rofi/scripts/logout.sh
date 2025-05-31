#!/usr/bin/env bash
## Credit Aditya Shakya (adi1090x)
## Credit Postcybepunk

# Options
shutdown='  '
reboot='  '
lock='  '
logout='  '
yes="YES"
no="NO"

uptime="$(uptime -p | sed -e 's/up //g')"
host=$(hostname)

open_rofi() {
	rofi -theme "$HOME/.config/rofi/tools/logout.rasi" \
		-kb-accept-entry 'Return,space' \
		-p "$host" \
		-mesg "Uptime: $uptime" \
		-selected-row 1 -no-show-match -no-sort \
		-dmenu
}

open_menu() {
	echo -e "$reboot\n$shutdown\n$logout\n$lock" | open_rofi
}

#REFT: this is duplicated with my own cmd
confirm_rofi() {
	rofi -theme "$HOME/.config/rofi/tools/confirm.rasi" \
		-kb-accept-entry 'Return,space' \
		-selected-row 1 -no-show-match -no-sort \
		-dmenu
	# -theme ${dir}/${theme}.rasi
}

confirm_exit() {
	echo -e "$yes\n$no" | confirm_rofi
}

run_cmd() {
	selected="$(confirm_exit)"
	if [[ "$selected" == "$yes" ]]; then
		if [[ $1 == '--shutdown' ]]; then
			systemctl poweroff
		elif [[ $1 == '--reboot' ]]; then
			systemctl reboot
		elif [[ $1 == '--logout' ]]; then
			hyprctl dispatch exit 0
		fi
	else
		exit 0
	fi
}

chosen="$(open_menu)"
case ${chosen} in
"$shutdown")
	run_cmd --shutdown
	;;
"$reboot")
	run_cmd --reboot
	;;
"$lock")
	notify-send "no lock"
	;;
"$logout")
	run_cmd --logout
	;;
esac
