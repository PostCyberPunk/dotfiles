function vpn
    if systemctl is-active --quiet v2raya.service
        echo "v2raya service is running"
        systemctl stop v2raya.service
        echo "v2raya service stopped"
    else
        echo "v2raya service is not running"
        systemctl start v2raya.service
        echo "v2raya service started"
    end
end
