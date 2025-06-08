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
_get_func() {
	declare -F | awk '{print $3}' | grep -v '^_'
}
_print_cmds() {
	fd -e sh . "$src_dir" -d1 --exec basename -s .sh {}
}
_print_subcmds() {
	_file="$src_dir/$1.sh"
	if [[ -f $_file ]]; then
		source "$_file"
		_get_func
	else
		echo ""
	fi
}
if [[ -n "$*" ]]; then
	# TODO:Use an extra file for these two
	if [[ $1 == "-h" ]]; then
		_print_cmds
		exit
	fi
	if [[ $1 == "-hs" ]]; then
		_print_subcmds $2
		exit
	fi
	# _group "$@"
	_file="$src_dir/$1.sh"
	if [[ -f $_file ]]; then
		source "$_file"
		if [[ -n $(_get_func | grep -w $2) ]]; then
			$2 "${@:3}"
		else
			echo "Can't find Subcommand <$2> in <$1> try:"
			_get_func | sed 's/^/\t/g'
		fi
	fi
else
	echo "Usage: pcmds <subcommand>"
	echo "Subcommands:"
	_print_cmds | sed 's/^/\t/g'
fi
