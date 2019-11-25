#!/bin/bash

groupadd -g 80 www
adduser -o --home /www --uid 80 --gid 80 -c "Web Application" www

dnf install -y gcc gcc-c++ make automake autoconf patch \
curl-devel libmcrypt-devel mhash-devel gd-devel libjpeg-devel libpng-devel libXpm-devel libxml2-devel libxslt-devel openssl-devel recode-devel 
#dnf install openldap-devel net-snmp-devel

cd /usr/local/src/
wget http://tw2.php.net/get/php-5.5.8.tar.gz/from/this/mirror

#ln -s /usr/pgsql-9.2/lib/* /usr/lib/
#ln -s /usr/pgsql-9.2/include/* /usr/include/

tar zxf php-5.5.8.tar.gz
cd php-5.5.8

./configure --prefix=/srv/php-5.5.8 \
--with-config-file-path=/srv/php-5.5.8/etc \
--with-config-file-scan-dir=/srv/php-5.5.8/etc/conf.d \
--enable-fpm \
--with-fpm-user=www \
--with-fpm-group=www \
--with-pear \
--with-curl \
--with-gd \
--with-jpeg-dir \
--with-png-dir \
--with-freetype-dir \
--with-zlib-dir \
--with-iconv \
--with-mcrypt \
--with-mhash \
--with-pdo-mysql \
--with-mysql-sock=/var/lib/mysql/mysql.sock \
--with-openssl \
--with-xsl \
--with-recode \
--enable-sockets \
--enable-soap \
--enable-mbstring \
--enable-gd-native-ttf \
--enable-zip \
--enable-xml \
--enable-bcmath \
--enable-calendar \
--enable-shmop \
--enable-dba \
--enable-wddx \
--enable-sysvsem \
--enable-sysvshm \
--enable-sysvmsg \
--enable-opcache \
--enable-pcntl \
--enable-maintainer-zts \
--disable-debug

#--with-tsrm-pthreads \
#--with-mysql \
#--with-mysqli=/usr/bin/mysql_config \
#--with-pdo-pgsql=/usr/pgsql-9.2 \
#--with-pgsql=/usr/pgsql-9.2 \

make && make install

strip /srv/php-5.5.8/bin/php
strip /srv/php-5.5.8/bin/php-cgi
		
mkdir -p /srv/php-5.5.8/etc/conf.d
cp php.ini-* /srv/php-5.5.8/etc/
#cp /srv/php-5.5.8/etc/php.ini-development /srv/php-5.5.8/etc/php.ini
cp /srv/php-5.5.8/etc/php.ini-production /srv/php-5.5.8/etc/php.ini
cp /srv/php-5.5.8/etc/php-fpm.conf.default /srv/php-5.5.8/etc/php-fpm.conf
cp /srv/php-5.5.8/etc/pear.conf{,.original}
cp ./sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm
chmod +x /etc/init.d/php-fpm
chkconfig --add php-fpm
chkconfig php-fpm on

ln -s /srv/php-5.5.8/ /srv/php

vim /srv/php-5.5.8/etc/php-fpm.conf <<end > /dev/null 2>&1
:25,25s/;//
:32,32s/;//
:225,225s/pm.max_children = 5/pm.max_children = 512/
:251,251s/;pm.max_requests = 500/pm.max_requests = 1024/
:448,448s/;rlimit_files = 1024/rlimit_files = 20480/
:wq
end

vim /srv/php-5.5.8/etc/php.ini <<EOF > /dev/null 2>&1
:309,309s$;open_basedir =$open_basedir = /www/:/tmp/:/var/tmp/:/srv/php-5.5.8/lib/php/:/srv/php-5.5.8/bin/$
:376,376s/expose_php = On/expose_php = Off/
:406,406s/memory_limit = 128M/memory_limit = 32M/
:768,768s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=1/
:923,923s$;date.timezone =$date.timezone = Asia/Hong_Kong$
:1400,1400s:;session.save_path = "/tmp":session.save_path = "/dev/shm":
:1426,1426s/session.name = PHPSESSID/session.name = JSESSIONID/
:wq
EOF

#:706,706s!;include_path = ".:/php/includes"!include_path = ".:/srv/php-5.5.8/lib/php:/srv/php-5.5.8/share"!
#:728,728s!; extension_dir = "./"!extension_dir = "./:/srv/php-5.5.8/lib/php/extensions:/srv/php-5.5.8/lib/php/extensions/no-debug-non-zts-20121212"!
#:804,804s/upload_max_filesize = 2M/upload_max_filesize = 3M/

cat >> ~/.bashrc <<EOF
PATH=$PATH:/srv/php/bin:/srv/mysql/bin:/srv/nginx/bin:
EOF

#php -r 'phpinfo();'
