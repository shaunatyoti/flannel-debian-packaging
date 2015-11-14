# build flannel debian package

FLANNEL_VERSION=${FLANNEL_VERSION:-0.5.5}
REV=${REV:-2}

rm -f flannel/builds/flannel_$FLANNEL_VERSION_amd64.deb
rm -rf flannel/source/flannel-$FLANNEL_VERSION

mkdir -p flannel/builds
mkdir -p flannel/source
mkdir -p flannel/downloads

cd flannel/downloads

if [ -f flannel-$FLANNEL_VERSION-linux-amd64.tar.gz ]; then
  echo "already have the download ..."
else
  wget https://github.com/coreos/flannel/releases/download/v$FLANNEL_VERSION/flannel-$FLANNEL_VERSION-linux-amd64.tar.gz
fi

cd ../source
tar zxf ../downloads/flannel-$FLANNEL_VERSION-linux-amd64.tar.gz

fpm -s dir -n "flannel" \
-p ../builds \
-C flannel-${FLANNEL_VERSION} \
-v ${FLANNEL_VERSION}-${REV} \
-t deb \
-a amd64 \
-d "dpkg (>= 1.17)" \
--after-install ../scripts/deb/systemd/after-install.sh \
--before-install ../scripts/deb/systemd/before-install.sh \
--after-remove ../scripts/deb/systemd/after-remove.sh \
--before-remove ../scripts/deb/systemd/before-remove.sh \
--config-files etc/flanneld \
--license "Apache Software License 2.0" \
--maintainer "yoti <noc@yoti.com>" \
--vendor "yoti ltd" \
--description "flanneld network daemon" \
flanneld=/usr/sbin/flanneld \
../../etc/flanneld/flanneld.conf=/etc/flanneld/flanneld.conf \
../../services/systemd/flanneld.service=/lib/systemd/system/flanneld.service
