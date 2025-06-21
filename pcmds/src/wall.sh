#!/bin/bash
_link_wallpaper() {
	ln -sf "$PWD/$1" "$wallpaper_cache"
}

change() {
	if [[ -f $1 ]]; then
		mv -f "$wallpaper_cache" "$wallpaper_cache-bak"
		_link_wallpaper $1 || mv -f "$wallpaper_cache-bak" "$wallpaper_cache"
	fi
	swww query || swww-daemon && swww img $1 $SWWW_PARAMS
}

reload() {
	swww kill
	sleep 1
	swww-daemon &
}

switcher() {
	cd "$wallpaper_dir" || (noti_c "Wallpaer Directory not found" && exit)
	result=$(find . -type f | fzf \
		--reverse --header="WallPaperSwitcher" --preview-window=44% \
		--preview='kitten icat --clear --transfer-mode=memory --place="$FZF_PREVIEW_COLUMNS"x"$FZF_PREVIEW_LINES"@$(math $COLUMNS+5)x1 --align center --stdin=no -z -1 {}')
	if [ -z "$result" ]; then
		exit 1
	fi
	change "$result"
}
