#!/bin/bash

cd /usr/local/src/
rm -rf pthreads
git clone --depth=1 https://github.com/krakjoe/pthreads.git
cd pthreads/
/srv/php/bin/phpize 
./configure --with-php-config=/srv/php/bin/php-config


make -j8
make install

cat > /srv/php/etc/cli.d/pthreads.ini <<EOF
extension=pthreads.so
EOF
