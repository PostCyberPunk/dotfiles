#!/bin/bash
_term() {
	local class=""
	local detach=true
	local opacity=""
	local fontsize=""
	local title=""
	local -a other_flags=()

	while [[ $# -gt 0 ]]; do
		case $1 in
		-c)
			class="--class=$2 "
			shift 2
			;;
		-o)
			opacity="--background-opacity=$2 "
			shift 2
			;;
		-f)
			opacity="--font-size=$2 "
			shift 2
			;;
		-t)
			title="--title=$2 "
			shift 2
			;;
		-nodetach)
			detach=false
			shift 1
			;;
		--) # end of options
			shift
			other_flags+=("$@")
			break
			;;
		-*)
			other_flags+=("$1")
			if [[ "$2" && "$2" != -* ]]; then
				other_flags+=("$2")
				shift 2
			else
				shift
			fi
			;;
		*)
			other_flags+=("$1")
			shift
			;;
		esac
	done
	#FIX: will multi line cmd work?
	local _flag=$title$class$opacity$fontsize${other_flags[*]}

	if [ $detach ]; then
		ghostty $_flag &
	else
		ghostty $_flag
	fi
}
editor() {
	ghostty --class=nvim -e nvim $@
}
editor_mini() {
	ghostty -o background_opacity=0.1 --class flkt5 -e nvim "$@"
}
# not working
fm_pick() {
	ghostty --class flkt_fzf -o background_opacity=0.5 -e lf --selection-path={}
}
fm() {
	_term -e lf
}
fm_open() {
	_term -e fish -C lfcd
}
