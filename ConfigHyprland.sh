read -n 1 -p "Do you want to install Catppuccin-GTK-Theme,Cursor and icons?(y/N): " itheme
if [[ $itheme = [yY] ]]; then
	echo
	echo "Install Themes......"
	yay -S --needed catppuccin-cursors-mocha catppuccin-gtk-theme-mocha
	mkdir -p ~/Temp
	git clone --depth=1 -b mocha "https://github.com/PostCyberPunk/Catppuccin-GTK-Theme" ~/Temp/CatIcon
	mkdir -p ~/.icons
	mv ~/Temp/CatIcon/Catppuccin-Mocha ~/.icons/
	rm -rf ~/Temp/CatIcon
	echo "Done"
fi
dotinker=$(pwd)/lib/dotinker.sh
echo
read -n 1 -p "Do you want to link your GUI configs?(y/N)" dolinkdry
if [[ $dolinkdry = [yY] ]]; then
	echo
	echo "Test in Dryrun......"
	$dotinker -n 2gui-hypr
	echo
	read -n 1 -p "Link your config?:(y/N)" dolink

	if [[ $dolink = [yY] ]]; then
		echo
		echo "Linking configs......"
		$dotinker 2gui-hypr && echo "Linked"
	fi
fi

init_config() {
	chmod +x ~/.config/hypr/scripts/*
	chmod +x ~/.config/hypr/initial-boot.sh
	chmod +x ~/.config/rofi/scripts/*
	ln -sf "$HOME/.config/waybar/configs/[TOP & BOT] SummitSplit" "$HOME/.config/waybar/config"
	ln -sf "$HOME/.config/waybar/style/Catcha.css" "$HOME/.config/waybar/style.css"
	ln -sf "$HOME/.config/hypr/lib/GPU/1 Default.conf" "$HOME/.config/hypr/configs/GPU.conf"
	ln -sf "$HOME/.config/hypr/lib/Monitor/1 Default.conf" "$HOME/.config/hypr/configs/Monitors.conf"
	echo
	echo "Hypr now initialized"
}

echo
read -n 1 -p "Initilize Hypyland?:(y/N)" inithypr
if [[ $inithypr = [yY] ]]; then
	echo
	echo "Initilizing......"
	init_config
fi
