#!/bin/bash
cd /usr/local/src
wget https://cconv.googlecode.com/files/cconv-php-0.6.2.tar.gz
tar zxf cconv-php-0.6.2.tar.gz
cd cconv-php-0.6.2
/srv/php/bin/phpize
./configure --with-php-config=/srv/php/bin/php-config --with-cconv-dir=/srv/cconv-0.6.2

cat > /srv/php/etc/conf.d/cconv.ini <<EOF
extension=cconv.so
EOF
