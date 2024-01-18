if [[ "$EUID" = 0 ]]; then
	echo "Dont Run this in sudo"
	exit 1
fi
read -n1 -p "Install Modern Unix Collection?" munix
if [[ $munix = [yY] ]]; then
	yay -S --noconfirm --needed duf dust fd navi gping procs jq sd the_silver_searcher choose eza tldr rsync bat vivid atool p7zip unrar git-delta || echo "!!!!!Installation Failed!!!!!"
fi
read -n1 -p "Install LF Preview?" lfcp
if [[ $lfcp = [yY] ]]; then
	yay -S --needed --noconfirm ctpv-git chafa atool perl-image-exiftool jq glow ffmpegthumbnailer git-delta poppler bat vivid || echo "!!!!!Installation Failed!!!!!"
fi
# rm -r ~/.config/fish
dotinker=$(pwd)/DoTinker/dotinker.sh
$dotinker -nvb 1tui
read -p "Link your config fot tui core?:(y/N)" dostow
if [[ $dostow = [yY] ]]; then
	$dotinker -vbl 1tui
fi
read -p "Configure Tide prompt?" dotide
if [[ $dotide = [yY] ]]; then
	fish -c "tide configure --auto --style=Lean --prompt_colors='16 colors' --show_time=No --lean_prompt_height='Two lines' --prompt_connection=Disconnected --prompt_spacing=Compact --icons='Few icons' --transient=Yes"
	# FIX:need somehow refresh comandline
fi
