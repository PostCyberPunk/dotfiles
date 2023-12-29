if [[ "$EUID" = 0 ]]; then
	echo "Dont Run this in sudo"
	exit 1
fi
read -p "Install Modern Unix Collection?" munix
if [ $munix = "y" ]; then
	yay -S --needed duf dust fd navi gping procs jq sd the_silver_searcher choose eza tldr rsync
fi
read -p "Install LF Preview?" lfcp
if [ $lfcp = "y" ]; then
	yay -S --needed ctpv-git chafa atool perl-image-exiftool jq glow ffmpegthumbnailer git-delta poppler glmark2
fi
rm -r ~/.config/fish
stow -nv 1tui
read -p "Stow your config fot tui core?:(y/N)" dostow
if [ $dostow = "y" ]; then
	stow -v 1tui
else
	exit 0
fi
