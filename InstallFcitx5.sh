yay -S --needed fcitx5 fcitx5qt fcitx5gtk fcitx5-configtool fcitx5-chinese-addons fcitx5-pinyin-zhwiki
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
