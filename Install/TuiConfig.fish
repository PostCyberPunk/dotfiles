#!/usr/bin/fish
if test $EUID -eq 0
    echo "Dont Run this in sudo"
    exit 1
end
read -n1 -l munix -P "Install Modern Unix Collection?"
echo
if not test -z (string match -i $munix y)
    yay -S --noconfirm --needed duf dust gdu fd navi gping procs jq sd the_silver_searcher choose eza tldr rsync rclone bat vivid atool unzip p7zip unrar git-delta || echo "!!!!!Installation Failed!!!!!"
end

read -l lfcp -n1 -P "Install LF Preview?"
if not test -z (string match -i $lfcp y)
    yay -S --needed --noconfirm ctpv-git chafa atool perl-image-exiftool jq glow ffmpegthumbnailer git-delta poppler bat vivid || echo "!!!!!Installation Failed!!!!!"
end
# rm -r ~/.config/fish
set dotinker "$(pwd)/DoTinker/dotinker.sh"
bash $dotinker -nvb 1tui
read -l dostow -P "Link your config for tui core?:(y/N)"
if not test -z (string match -i $dostow y)
    bash $dotinker -vbl 1tui
    bat cache --build
end
read -l dotide -P "Configure Tide prompt?"
if not test -z (string match -i $dotide y)
    tide configure --auto --style=Lean --prompt_colors='16 colors' --show_time=No --lean_prompt_height='Two lines' --prompt_connection=Disconnected --prompt_spacing=Compact --icons='Few icons' --transient=Yes
    commandline -f repaint
end
