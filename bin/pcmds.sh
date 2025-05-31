#!/bin/bash
root_cmd_dir="$HOME/dotfiles/pcmds"
src_dir="$root_cmd_dir/src"
lib_dir="$root_cmd_dir/lib"
source "$root_cmd_dir/ref.sh"
source "$lib_dir/utils.sh"
source "$lib_dir/term.sh"

_help() {
	declare -F | awk '{print $3}' | grep -v '^_' | tr '\n' '\t' | fold -sw $(tput cols)
}
if [[ -n "$*" ]]; then
	# _group "$@"
	_file="$src_dir/$1.sh"
	if [[ -f $_file ]]; then
		source "$_file"
		$2 "${@:3}"
	fi
else
	_help
fi
