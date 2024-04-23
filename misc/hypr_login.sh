#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
read -n 1 -p "Use Normal or Prime(Nvidia)?(N/p)" choice
echo
if [[ "$choice" = "p" ]]; then
	hplg=$SCRIPT_DIR/lib/hplg_prime.fish
else
	hplg=$SCRIPT_DIR/lib/hplg_normal.fish
fi
cat $hplg >~/.config/fish/extra_login.fish
cat $SCRIPT_DIR/lib/hplg_menu.fish >>~/.config/fish/extra_login.fish
echo "Done!"
echo "Dont forget your to edit bootlader entries!"
echo "systemd.setenv=PCP_LOGIN_TTY=1"
