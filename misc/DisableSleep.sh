if [[ $EUID -ne 0 ]]; then
	echo "Failed:Run as root!"
	exit
fi
sudo tee -a >> /etc/systemd/sleep.conf << EOF
AllowSuspend=no
AllowHibernation=no
AllowSuspendThenHibernate=yes
AllowHybridSleep=no
EOF
