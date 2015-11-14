getent group flanneld >/dev/null || groupadd -r flanneld
getent passwd flanneld >/dev/null || useradd -r -g flanneld -d /var/flanneld \
  -s /sbin/nologin -c "flanneld user" flanneld

mkdir -p -m 755 /var/flanneld
chown -R flanneld /var/flanneld
chgrp -R flanneld /var/flanneld
