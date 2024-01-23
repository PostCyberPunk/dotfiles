if [[ $EUID -ne 0 ]]; then
	echo "Failed:Run as root!"
	exit
fi
read -p "Auto Login User: " uname
tname='$TERM'
_ty_dir=/etc/systemd/system/getty@tty1.service.d
[ ! -d "$_ty_dir" ]&&mkdir -p "$_ty_dir"
cat >"$_ty_dir/autologin.conf" <<EOF
[Service]
ExecStart=
ExecStart=-/sbin/agetty -o '-p -f -- \\u' --noclear --autologin $uname %I $tname
EOF
# _login_cfg=$(grep "is-login" <~/.config/fish/extra_login.fish)
_login_cfg="~/.config/fish/extra_login.fish"
if [[ ! -f $_login_cfg ]]; then
	cat >/home/$uname/.config/fish/extra_login.fish <<EOF
if status is-login
    if test -z "\$DISPLAY" -a \$XDG_VTNR -eq 1 
        exec Hyprland >.hyprlog.txt 2> hyprerr.txt
    end
end
EOF
fi
