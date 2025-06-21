#!/bin/bash
source "$lib_dir/current_theme.sh"
set() {
	local _themefile="$lib_dir/themes/$1.sh"
	if [[ -f $_themefile ]]; then
		ln -sf "$_themefile" "$lib_dir/current_theme.sh"
	else
		noti_c "Cannot find $1"
		echo "Cannot find $1"
		exit 1
	fi
}
apply() {
	dconf write /org/gnome/desktop/interface/color-scheme "'$color_scheme'" >/dev/null 2>&1 &
	dconf write /org/gnome/desktop/interface/gtk-theme "'$gtk_theme'" >/dev/null 2>&1 &
	dconf write /org/gnome/desktop/interface/icon-theme "'$icon_theme'" >/dev/null 2>&1 &
	dconf write /org/gnome/desktop/interface/cursor-theme "'$cursor_theme'" >/dev/null 2>&1 &
	dconf write /org/gnome/desktop/interface/cursor-size "'$cursor_size'" >/dev/null 2>&1 &
	dconf write /org/gnome/desktop/interface/font "'$gtk_font'" >/dev/null 2>&1 &
	kvantummanager --set "$kvan_theme"
}

list_themes() {
	cd $lib_dir/themes || exit 1
	fd | sed -e 's/\.sh$//g'
}

apply_hypr_cursor() {
	hyprctl setcursor "$cursor_theme" "$cursor_size"
}
