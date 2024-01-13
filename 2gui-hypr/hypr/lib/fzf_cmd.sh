#!/bin/bash
source ~/.config/hypr/lib/ref.sh
source ~/.config/hypr/lib/system_cmd.sh
source ~/.config/hypr/lib/ui_cmd.sh

wallpaper_switcher() {
	cd $wallpaper_dir
	result=$(find . -type f | fzf \
		--reverse --header="WallPaperSwitcher" --preview-window=44% \
		--preview='kitten icat --clear --transfer-mode=memory --place="$FZF_PREVIEW_COLUMNS"x"$FZF_PREVIEW_LINES"@$(math $COLUMNS+5)x1 --align center --stdin=no -z -1 {}')
	change_wallpaper $result
}

clipboard_manager() {
  export SHELL=bash
	result=$(
		cliphist list | fzf --reverse -m \
			--prompt="ClipHistory> " \
			--preview-window="bottom:3:wrap" \
			--preview='echo {}' \
			--bind='ctrl-d:execute(echo -n {}|cliphist delete)+reload(cliphist list)' \
      --bind='enter:execute-silent(echo '{}'|cliphist decode|wl-copy)+abort' \
      --bind='ctrl-delete:accept'
	)
	if [[ $? -eq 0 ]]; then
		echo "$result" | while read -r line; do
			printf "$line" | cliphist delete
		done
	else
		exit
	fi
}
