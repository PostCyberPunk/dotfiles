#!/bin/bash

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

linker_fzf() {
	# use fzf create a symbolic link from source_file  to selected file in target directory
	source_dir="${1%/}"
	target_file="$2"
	_filename=$(readlink $target_file)
	_filename=$(basename $_filename)
	_filename="${_filename%.*}"
	usage() {
		echo "Usage: linker.sh [source_dir] [target_file] "
	}
	# check if target directory exists
	if [ ! -d $source_dir ] || [ -z $source_dir ]; then
		echo "Target directory does not exist"
		usage
		exit 1
	fi
	# check if source file is null
	if [ -z $target_file ]; then
		echo "target file is null"
		usage
		exit 1
	fi
	# use fzf to select a file from target directory
	file_selected="$(find $source_dir -type f -printf "%f\n" | fzf --header "now:"$_filename --ansi --reverse --preview "bat --color=always --style=header,numbers $source_dir/{}" \
		--preview-window "wrap" --bind ctrl-y:preview-up,ctrl-e:preview-down,ctrl-b:preview-page-up,ctrl-f:preview-page-down,ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down)"

	if [ -z $file_selected ]; then
		echo "No file selected"
		exit 1
	fi
	source_file="$source_dir/$file_selected"
	# echo $source_file
	ln -sf "$source_file" "$target_file"
	if [ $? -eq 0 ]; then
		echo "Link created $source_file -> $target_file"
		notify-send $file_selected
	else
		echo "Link creation failed"
		notify-send "Link create failed"
	fi
}

gpu_switcher() {
	linker_fzf $gpu_src_dir $gpu_target_file
	notify-send "GPU Switched"
	hyprctl dispatch forcerendererreload
	hyprctl reload
}

monitor_switcher() {
	linker_fzf $monitor_src_dir $monitor_target_file
	notify-send "Monitor layout Switched"
	hyprctl reload
}

nvim_workspace() {
	ws_dir=$(tv nvim-session)
	cd $ws_dir
	direnv exec . nvim -c "set shell=fish"
}
