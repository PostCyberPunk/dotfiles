if [[ "$EUID" = 0 ]]; then
	echo "Dont Run this in sudo"
	exit 1
fi
read -p "Install Modern Unix Collection?" munix
if [[ $munix = [yY] ]]; then
	yay -S --needed duf dust fd navi gping procs jq sd the_silver_searcher choose eza tldr rsync bat vivid || echo "!!!!!Installation Failed!!!!!"
fi
read -p "Install LF Preview?" lfcp
if [[ $lfcp = [yY] ]]; then
	yay -S --needed ctpv-git chafa atool perl-image-exiftool jq glow ffmpegthumbnailer git-delta poppler glmark2 bat vivid || echo "!!!!!Installation Failed!!!!!"
fi
# rm -r ~/.config/fish
dotinker=$(pwd)/lib/dotinker.sh
dotinker -n 1tui
read -p "Link your config fot tui core?:(y/N)" dostow
if [[ $dostow = [yY] ]]; then
	dotinker 1tui
else
	exit 0
fi
