#!/bin/bash
if [[ $EUID -ne 0 ]]; then
	echo "Failed:Run as root!"
	exit
fi
read -p "Auto Login User: " uname
tname='$TERM'
_ty_dir=/etc/systemd/system/getty@tty1.service.d
[ ! -d "$_ty_dir" ] && mkdir -p "$_ty_dir"
cat >"$_ty_dir/autologin.conf" <<EOF
[Service]
ExecStart=
ExecStart=-/sbin/agetty -o '-p -f -- \\u' --noclear --autologin $uname %I $tname
EOF
