sudo tee -a >> /etc/systemd/sleep.conf << EOF
AllowSuspend=no
AllowHibernation=no
AllowSuspendThenHibernate=yes
AllowHybridSleep=no
EOF
