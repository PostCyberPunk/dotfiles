read -p "Install laptop conf?" ilap
yay -S --noconfirm --needed gcc
mkdir -p ~/Temp
git clone https://github.com/rvaiya/keyd ~/Temp/keyd

if [[ ! $? -e 0 ]]; then
	echo "clone failed"
	exit 1
fi

cd ~/Temp/keyd
make && sudo make install
if [[ $ilap = [Yy] ]]; then
	# TODO: this path is pretty bad
	sudo ln -sf ~/dotfiles/keyd/laptop.conf /etc/keyd/laptop.conf
fi
sudo ln -sf ~/dotfiles/keyd/redox.conf /etc/keyd/redox.conf
sudo systemctl enable keyd && sudo systemctl start keyd
date
