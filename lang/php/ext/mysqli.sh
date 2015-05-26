#!/bin/bash

cd /usr/local/src/php-5.*/ext/mysqli

/srv/php/bin/phpize
./configure --with-php-config=/srv/php/bin/php-config
make && make install
		
		
mkdir -p /srv/php/etc/conf.d		
cat > /srv/php/etc/conf.d/mysqli.ini <<EOF
extension=mysqli.so
EOF
		
