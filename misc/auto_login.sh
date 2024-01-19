if [[ $EUID -ne 0 ]]; then 
  echo "Failed:Run as root!"
  exit
fi
read -p "Auto Login User: " uname
tname='$TERM'
mkdir /etc/systemd/system/getty@tty1.service.d
cat > /etc/systemd/system/getty@tty1.service.d/autologin.conf <<EOF
[Service]
ExecStart=
ExecStart=-/sbin/agetty -o '-p -f -- \\u' --noclear --autologin $uname %I $tname
EOF
