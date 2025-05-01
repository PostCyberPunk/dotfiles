if [[ "$EUID" = 0 ]]; then
	echo "Dont Run this in sudo"
	exit 1
fi
yay -S --noconfirm --needed neovim gcc fzf fd ripgrep lazygit sudo nerd-fonts-profont luarocks || echo "!!!!!Installation Failed!!!!!"
git clone https://github.com/postcypunk/Lazyvim ~/.config/nvim

# install

cp ~/.config/nvim/lua/pcp/extra ~/.config/nvim/lua/pcp/extra.lua
