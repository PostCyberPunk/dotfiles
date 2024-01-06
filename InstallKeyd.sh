read -p "Install laptop conf?" ilap
yay -S --noconfirm  --needed gcc
mkdir -p ~/Temp
git clone https://github.com/rvaiya/keyd ~/Temp/keyd
cd ~/Temp/keyd
make && sudo make install
if [[ $ilap = [Yy] ]]; then
	sudo ln -sf ~/dotfiles/keyd/laptop.conf /etc/keyd/laptop.conf
fi
sudo ln -sf ~/dotfiles/keyd/redox.conf /etc/keyd/redox.conf
sudo systemctl enable keyd && sudo systemctl start keyd
date
