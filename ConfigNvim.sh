if [[ "$EUID" = 0 ]]; then
	echo "Dont Run this in sudo"
	exit 1
fi
yay -S --needed nvim gcc fzf fd ripgrep lazygit sudo nerd-fonts-profont || echo "!!!!!Installation Failed!!!!!"
git clone https://github.com/postcypunk/Lazyvim ~/.config/nvim
