yay -S --needed catppuccin-cursors-mocha catppuccin-gtk-theme-mocha
mkdir -p ~/Temp/
git clone --depth=1 -b mocha "https://github.com/PostCyberPunk/Catppuccin-GTK-Theme"
mkdir -p ~/.icons
cp -r Catppuccin-GTK-Theme/Catppuccin-Mocha/ ~/.icons
dotinker=$(pwd)/lib/dotinker.sh
dotinker -n 2gui-hypr
read -p "Link your config and initilize Hypyland?:(y/N)" dostow
if [[ $dostow = [yY] ]]; then
	dotinker 2gui-hypr && echo "Linked"
else
	exit 0
fi
init_config() {
	chmod +x ~/.config/hypr/scripts/*
	chmod +x ~/.config/hypr/initial-boot.sh
	chmod +x ~/.config/rofi/scripts/*
	ln -sf "$HOME/.config/waybar/configs/[TOP & BOT] SummitSplit" "$HOME/.config/waybar/config"
	ln -sf "$HOME/.config/waybar/style/Catcha.css" "$HOME/.config/waybar/style.css"
	ln -sf "$HOME/.config/hypr/lib/GPU/1 Default.conf" "$HOME/.config/hypr/configs/GPU.conf"
	ln -sf "$HOME/.config/hypr/lib/Monitor/1 Default.conf" "$HOME/.config/hypr/configs/Monitors.conf"
	echo "Hypr now initialized"
}
init_config
