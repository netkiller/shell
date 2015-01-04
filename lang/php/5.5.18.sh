#!/bin/bash

groupadd -g 80 www
adduser -o --home /www --uid 80 --gid 80 -c "Web Application" www

#automake autoconf
yum install -y gcc gcc-c++ make patch \
curl-devel libmcrypt-devel mhash-devel gd-devel libjpeg-devel libpng-devel libXpm-devel libxml2-devel libxslt-devel openssl-devel recode-devel 
#yum install openldap-devel net-snmp-devel

yum localinstall -y http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm
yum install mysql-community-devel -y

yum install -y http://yum.postgresql.org/9.3/redhat/rhel-6-x86_64/pgdg-centos93-9.3-1.noarch.rpm
yum install -y postgresql93-devel

cd /usr/local/src/
wget http://cn2.php.net/distributions/php-5.5.18.tar.bz2

if [ -s php-5.5.18.tar.bz2 ]; then
tar jxf php-5.5.18.tar.bz2
cd php-5.5.18

./configure --prefix=/srv/php-5.5.18 \
--with-config-file-path=/srv/php-5.5.18/etc \
--with-config-file-scan-dir=/srv/php-5.5.18/etc/conf.d \
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
--with-mysqli=/usr/bin/mysql_config \
--with-pdo-pgsql=/usr/pgsql-9.3 \
--with-openssl \
--with-xsl \
--with-recode \
--enable-sockets \
--enable-soap \
--enable-mbstring \
--enable-exif \
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
--with-tsrm-pthreads \
--disable-debug

#--with-mysql \

[[ $? -ne 0 ]] && echo "Error: configure" &&  exit $?

make -j8

[[ $? -ne 0 ]] && echo "Error: make" &&  exit $?

if [ $(id -u) != "0" ]; then
    sudo make install
else
	make install
fi

[[ $? -ne 0 ]] && echo "Error: make install" &&  exit $?

strip /srv/php-5.5.18/bin/php
strip /srv/php-5.5.18/bin/php-cgi

mkdir -p /srv/php-5.5.18/etc/conf.d
mkdir -p /srv/php-5.5.18/etc/fpm.d
cp /srv/php-5.5.18/etc/pear.conf{,.original}
cp php.ini-* /srv/php-5.5.18/etc/
cp /srv/php-5.5.18/etc/php.ini-production /srv/php-5.5.18/etc/php.ini
cp /srv/php-5.5.18/etc/php.ini-development /srv/php-5.5.18/etc/php.cli.ini
cp /srv/php-5.5.18/etc/php-fpm.conf.default /srv/php-5.5.18/etc/php-fpm.conf

#\cp sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm
yes|cp sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm
chmod +x /etc/init.d/php-fpm
chkconfig --add php-fpm
chkconfig php-fpm on

rm -f /srv/php
ln -s /srv/php-5.5.18/ /srv/php

vim /srv/php-5.5.18/etc/php-fpm.conf <<end > /dev/null 2>&1
:25,25s/;//
:32,32s/;//
:93,93s/;rlimit_files = 1024/rlimit_files = 65536/
:225,225s/pm.max_children = 5/pm.max_children = 2048/
:251,251s/;pm.max_requests = 500/pm.max_requests = 1024/
:448,448s/;rlimit_files = 1024/rlimit_files = 40960/
:wq
end

#:15,15s/;//

vim /srv/php-5.5.18/etc/php.ini <<EOF > /dev/null 2>&1
:299,299s$;open_basedir =$open_basedir = /www/:/tmp/:/var/tmp/:/srv/php-5.5.18/lib/php/:/srv/php-5.5.18/bin/$
:366,366s/expose_php = On/expose_php = Off/
:396,396s/memory_limit = 128M/memory_limit = 32M/
:758,758s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=1/
:913,913s:;date.timezone =:date.timezone = Asia/Hong_Kong:
:1390,1390s:;session.save_path = "/tmp":session.save_path = "/dev/shm":
:1416,1416s/session.name = PHPSESSID/session.name = JSESSIONID/
:wq
EOF

#s/max_execution_time = 30/max_execution_time = 300/g
#:706,706s!;include_path = ".:/php/includes"!include_path = ".:/srv/php-5.5.18/lib/php:/srv/php-5.5.18/share"!
#:728,728s!; extension_dir = "./"!extension_dir = "./:/srv/php-5.5.18/lib/php/extensions:/srv/php-5.5.18/lib/php/extensions/no-debug-non-zts-20121212"!
#:804,804s/upload_max_filesize = 2M/upload_max_filesize = 3M/

vim /srv/php-5.5.18/etc/php.cli.ini <<EOF > /dev/null 2>&1
:396,396s/memory_limit = 128M/memory_limit = 4G/
:575,575s/;//
:913,913s:;date.timezone =:date.timezone = Asia/Hong_Kong:
:wq
EOF

cat >> /etc/man.config <<EOF
MANPATH  /srv/php/man/
EOF

cat >> /etc/profile.d/php.sh <<EOF
export PATH=/srv/php/bin:$PATH
EOF

cat >> ~/.bashrc <<'EOF'

alias php='php -c /srv/php/etc/php.cli.ini'
EOF
