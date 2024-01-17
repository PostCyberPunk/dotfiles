#!/bin/bash

link_cmd() {
	local src=$1
	local tgt=$2
  src=${src/#\~/$HOME}
  tgt=${tgt/#\~/$HOME}
	if [[ $src != "" ]] && [[ $tgt != "" ]]; then
		ln -s "$src" "$tgt"
		[ $? -eq 0 ] && echo "$(tput setaf 1)Link created$(tput sgr0)$src -> $tgt"
	else
		echo "$(tput setaf 1)argument is null$(tput sgr0)"
	fi
}

link_list() {
	local link_list_file="$1"
	while read -r line; do
		link_cmd $line
	done <$link_list_file
	date
}
add_x_list() {
	local exec_list_file="$1"
	while read -r line; do
		if [[ ! $line = "" ]]; then
			line=${line/#\~/$HOME}
			chmod +x $line
			[ $? -eq 0 ] && echo "Add x to $line" || echo "Fail to add x to $line"
		fi
	done <"$exec_list_file"
}
