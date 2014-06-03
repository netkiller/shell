#!/bin/bash

groupadd -g 80 www
adduser -o --home /www --uid 80 --gid 80 -c "Web Application" www

yum install -y gcc gcc-c++ make automake autoconf patch
yum install -y libtool-ltdl-devel
yum install -y curl-devel libmcrypt-devel mhash-devel gd-devel libjpeg-devel libpng-devel libXpm-devel libxml2-devel libxslt-devel openssl-devel recode-devel 
 
yum localinstall -y MySQL-devel-5.5.32-1.el6.x86_64.rpm 
yum localinstall -y MySQL-shared-5.5.32-1.el6.x86_64.rpm
yum localinstall -y MySQL-shared-compat-5.5.32-1.el6.x86_64.rpm

cd /usr/local/src/
wget http://hk2.php.net/get/php-5.3.25.tar.gz/from/this/mirror

#ln -s /usr/pgsql-9.2/lib/* /usr/lib/
#ln -s /usr/pgsql-9.2/include/* /usr/include/

tar zxf php-5.3.25.tar.gz
cd php-5.3.25

./configure --prefix=/srv/php-5.3.25 \
--with-config-file-path=/srv/php-5.3.25/etc \
--with-config-file-scan-dir=/srv/php-5.3.25/etc/conf.d \
--with-apxs2=/srv/httpd-2.4.4/bin/apxs \
--with-libdir=lib64 \
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
--with-mysql \
--with-mysqli=/usr/bin/mysql_config \
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
--enable-pcntl \
--disable-debug

#--with-tsrm-pthreads \
#--with-pdo-pgsql=/usr/pgsql-9.2 \
#--with-pgsql=/usr/pgsql-9.2 \

make && make install

strip /srv/php-5.3.25/bin/php
		
mkdir -p /srv/php-5.3.25/etc/conf.d
cp php.ini-* /srv/php-5.3.25/etc/
#cp /srv/php-5.3.25/etc/php.ini-development /srv/php-5.3.25/etc/php.ini
cp /srv/php-5.3.25/etc/php.ini-production /srv/php-5.3.25/etc/php.ini
cp /srv/php-5.3.25/etc/pear.conf{,.original}

ln -sv /srv/php-5.3.25/ /srv/php		

vim /srv/php-5.3.25/etc/php.ini <<EOF > /dev/null 2>&1
:379,379s$;open_basedir =$open_basedir = /www/:/tmp/:/var/tmp/:/srv/php-5.3.25/lib/php/:/srv/php-5.3.25/bin/$
:435,435s/expose_php = On/expose_php = Off/
:465,465s/memory_limit = 128M/memory_limit = 16M/
:796,796s!;include_path = ".:/php/includes"!include_path = ".:/srv/php-5.3.25/lib/php:/srv/php-5.3.25/share"!
:854,854s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=1/
:891,891s/upload_max_filesize = 2M/upload_max_filesize = 3M/
:1008,1008s$;date.timezone =$date.timezone = Asia/Hong_Kong$
:1490,1490s:;session.save_path = "/tmp":session.save_path = "/dev/shm":
:1508,1508s/session.name = PHPSESSID/session.name = JSESSIONID/
:wq
EOF

/srv/php-5.3.25/bin/pecl install apc
#ln -s /srv/php-5.3.25/lib/php/extensions/no-debug-non-zts-20100525/apc.so /srv/php-5.3.25/lib/php/extensions/
cat > /srv/php-5.3.25/etc/conf.d/apc.ini <<EOF
extension=apc.so
EOF

cat >> ~/.bash_profile <<EOF

export PATH=$PATH:/srv/php/bin
EOF

php -r 'phpinfo();' |grep apc
