#!/bin/bash

yum install git -y
git clone git://github.com/nicolasff/phpredis.git

cd phpredis
phpize
./configure --with-php-config=/srv/php/bin/php-config
make && make install

ln -s /srv/php/lib/php/extensions/*/redis.so /srv/php/lib/php/extensions/

cat > /srv/php/etc/conf.d/redis.ini <<EOF
extension=redis.so
EOF