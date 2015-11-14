# if [ $1 -eq 0 ] ; then
        # Package removal, not upgrade
        chkconfig flanneld off >/dev/null 2>&1 || :

        service flanneld stop >/dev/null 2>&1 || :

        update-rc.d -f flanneld remove >/dev/null 2>&1 || :
# fi
