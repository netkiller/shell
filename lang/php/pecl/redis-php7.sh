#!/bin/bash

cd /usr/local/src
wget -c https://github.com/phpredis/phpredis/archive/php7.zip
unzip php7.zip

cd phpredis-php7
/srv/php-7.0.0/bin/phpize
./configure --with-php-config=/srv/php-7.0.0/bin/php-config
make -j 8
make install

cat > /srv/php-7.0.0/etc/conf.d/redis.ini <<EOF
extension=redis.so
EOF

cd -
