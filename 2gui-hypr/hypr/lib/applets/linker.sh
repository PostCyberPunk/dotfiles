#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

# Function to display menu options
menu() {
	options=()
	while IFS= read -r file; do
		if [ -f "$config_dir/$file" ]; then
			options+=("$(basename "$file" $extens)")
		fi
	done < <(find "$config_dir" -maxdepth 1 -type f -name "*$extens" -exec basename {} \; | sort)

	printf '%s\n' "${options[@]}"
}

# Apply selected style
apply_link() {
	ln -sf "$config_dir/$1$extens" "$target_file"
	after_apply
}

# Main function
main() {
	choice=$(menu | rofi -dmenu -config "$rofi_config")

	if [[ -z "$choice" ]]; then
		echo "No option selected. Exiting."
		exit 0
	fi

	apply_link "$choice"
}

# Kill Rofi if already running before execution
if pgrep -x "rofi" >/dev/null; then
	pkill rofi
	exit 0
fi

main
