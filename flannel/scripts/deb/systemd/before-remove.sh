        # Package removal, not upgrade
        systemctl --no-reload disable flanneld.service > /dev/null 2>&1 || :
        systemctl stop flanneld.service > /dev/null 2>&1 || :
