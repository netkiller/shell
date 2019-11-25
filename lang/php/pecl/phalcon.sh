#!/bin/sh
cd /usr/local/src/

rm -rf cphalcon

if [ ! -f /usr/bin/git ]; then 
dnf install -y git
fi
		
git clone --depth=1 git://github.com/phalcon/cphalcon.git
cd cphalcon/build
./install

cat > /srv/php/etc/conf.d/phalcon.ini <<EOF
extension=phalcon.so
EOF
