#!/bin/bash

cd /usr/local/src
git clone https://github.com/netkiller/safenet-php.git
cd safenet-php
/srv/php/bin/phpize
./configure --with-php-config=/srv/php/bin/php-config
make
make install


cat > /srv/php/etc/conf.d/safenet.ini <<PHP
extension=safenet.so
[SafeNet]
safenet.url=http://175.145.40.55/safe/interface
safenet.key=Web01-key
PHP