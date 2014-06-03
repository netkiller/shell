#!/bin/sh
cd /usr/local/src/
		
git clone git://github.com/phalcon/cphalcon.git
cd cphalcon/build
./install

cat > /srv/php/etc/conf.d/phalcon.ini <<EOF
extension=phalcon.so
EOF
