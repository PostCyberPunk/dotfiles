if [[ $EUID -ne 0 ]]; then
	echo "Failed:Run as root!"
	exit
fi
read -p "Auto Login User: " uname
tname='$TERM'
mkdir /etc/systemd/system/getty@tty1.service.d
cat >/etc/systemd/system/getty@tty1.service.d/autologin.conf <<EOF
[Service]
ExecStart=
ExecStart=-/sbin/agetty -o '-p -f -- \\u' --noclear --autologin $uname %I $tname
EOF
_login_cfg=$(grep "is-login")
if [[ $_login_cfg = "" ]]; then
	tee -a >>~/.config/fish/config.fish <<EOF
if status is-login
    if test -z "$DISPLAY" -a $XDG_VTNR -eq 1 
        exec Hyprland >.hyprlog.txt 2> hyprerr.txt
    end
end
EOF
fi
