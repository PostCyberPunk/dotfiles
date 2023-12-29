read -p "Install laptop conf?" ilap
yay -S --needed gcc
mkdir -p ~/Temp
git clone https://github.com/rvaiya/keyd ~/Temp/keyd
cd ~/Temp/keyd
make && sudo
make install
sudo systemctl enable keyd && sudo systemctl start keyd
if ["$ilap" = "y"]; then
	sudo ln -sf ~/dotfiles/keyd/laptop.conf /etc/keyd/laptop.conf
fi
date
