#!/bin/bash

if [ ! -f /usr/bin/unzip ]; then
yum install -y unzip 
fi

cd /usr/local/src
wget -c https://github.com/phpredis/phpredis/archive/3.1.6.zip
unzip 3.1.6.zip

cd phpredis-3.1.6 
/srv/php-7.2.1/bin/phpize
./configure --with-php-config=/srv/php-7.2.1/bin/php-config
make -j 8
make install

cat > /srv/php-7.2.1/etc/conf.d/redis.ini <<EOF
extension=redis.so
EOF

cd -
