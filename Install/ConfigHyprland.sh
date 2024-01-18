#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source $SCRIPT_DIR/lib/util.sh

read -n 1 -p "Do you want to install Catppuccin-GTK-Theme,Cursor and icons?(y/N): " itheme
	echo
if [[ $itheme = [yY] ]]; then
	echo "Install Themes......"
	yay -S --noconfirm --needed catppuccin-cursors-mocha catppuccin-gtk-theme-mocha
	mkdir -p ~/Temp
	git clone --depth=1 -b mocha "https://github.com/PostCyberPunk/Catppuccin-GTK-Theme" ~/Temp/CatIcon
	mkdir -p ~/.icons
	mv ~/Temp/CatIcon/Catppuccin-Mocha ~/.icons/
	rm -rf ~/Temp/CatIcon
	echo "Done"
fi
dotinker=$(pwd)/DoTinker/dotinker.sh
echo
read -n 1 -p "Do you want to link your GUI configs?(y/N)" dolinkdry
	echo
if [[ $dolinkdry = [yY] ]]; then
	echo "Test in Dryrun......"
	$dotinker -nvb 2gui-hypr
	echo
	read -n -p "Link your config?:(y/N)" dolink

	if [[ $dolink = [yY] ]]; then
		echo
		echo "Linking configs......"
		$dotinker -vbl 2gui-hypr && echo "Link" || echo "Something is wrong"
	fi
fi

init_config() {
	link_list "$SCRIPT_DIR/lib/hypr_link.txt"
	add_x_list "$SCRIPT_DIR/lib/hypr_chmod.txt"
	echo
	echo "Hypr now initialized"
}

echo
read -n 1 -p "Initilize Hypyland?:(y/N)" inithypr
	echo
if [[ $inithypr = [yY] ]]; then
	echo "Initilizing......"
	init_config
fi
