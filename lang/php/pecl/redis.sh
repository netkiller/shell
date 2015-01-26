#!/bin/bash

#yum install git -y
#git clone git://github.com/nicolasff/phpredis.git

#cd phpredis
#/srv/php/bin/phpize
#./configure --with-php-config=/srv/php/bin/php-config
#make && make install

pecl install redis

cat > /srv/php/etc/conf.d/redis.ini <<EOF
extension=redis.so
EOF
