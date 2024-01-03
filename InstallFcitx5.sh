if [[ "$EUID" != 0 ]]; then
	echo "Run this in sudo"
	exit 1
fi
read -p "Input your username if want to install fcitx5:" uname
if [[ -z $uname ]]; then
	echo "Aborted"
	exit
fi
sudo -u $uname yay -S --needed fcitx5 fcitx-5qt fcitx5-gtk fcitx5-configtool fcitx5-chinese-addons fcitx5-pinyin-zhwiki
read -p "Export environment variables?(y/N)" ienv
if [[ ienv != [yY] ]]; then
	echo "Exit"
	exit
fi
tee -a >>/etc/environment <<EOF
#fcitx
#GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx
SDL_IM_MODULE=fcitx
GLFW_IM_MODULE=ibus
EOF
echo "Enable cloud in configTool pinyin section"
date
