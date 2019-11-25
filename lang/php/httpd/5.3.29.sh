#!/bin/bash

cd /usr/local/src/

dnf install -y curl-devel libmcrypt-devel mhash-devel gd-devel libjpeg-devel libpng-devel libXpm-devel libxml2-devel libxslt-devel openssl-devel recode-devel 
#dnf install openldap-devel net-snmp-devel

dnf localinstall -y http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm
dnf install mysql-community-devel -y

wget http://cn2.php.net/distributions/php-5.3.29.tar.bz2
tar jxf php-5.3.29.tar.bz2
cd php-5.3.29

./configure --prefix=/srv/php-5.3.29 \
--with-config-file-path=/srv/php-5.3.29/etc \
--with-config-file-scan-dir=/srv/php-5.3.29/etc/conf.d \
--with-apxs2=/srv/httpd-2.2.29/bin/apxs \
--with-libdir=lib64 \
--with-pear \
--with-curl \
--with-iconv \
--with-gd \
--with-jpeg-dir \
--with-png-dir \
--with-freetype-dir \
--with-zlib-dir \
--with-mcrypt \
--with-mhash \
--with-mysql \
--with-mysqli=/usr/bin/mysql_config \
--with-pdo-mysql \
--with-mysql-sock=/var/lib/mysql/mysql.sock \
--with-openssl \
--with-xsl \
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
--disable-maintainer-zts \
--disable-safe-mode \
--disable-debug

#--enable-sysvsem \
#--enable-sysvshm \
#--enable-sysvmsg \
#--enable-pcntl \
#--with-tsrm-pthreads \

make -j8 && make install

mkdir -p /srv/php-5.3.29/etc/conf.d/
cp php.ini-* /srv/php-5.3.29/etc/
cp /srv/php-5.3.29/etc/php.ini-production /srv/php-5.3.29/etc/php.ini
cp /srv/php-5.3.29/etc/pear.conf{,.original}

strip /srv/php-5.3.29/bin/php

ln -s /srv/php-5.3.29/ /srv/php

cat >> /etc/man.config <<EOF
MANPATH  /srv/php/man/
EOF

cat >> /etc/profile.d/php.sh <<EOF
export PATH=/srv/php/bin:$PATH
EOF

vim /srv/php-5.3.29/etc/php.ini <<EOF > /dev/null 2>&1
:379,379s$;open_basedir =$open_basedir = /www/:/tmp/:/var/tmp/:/srv/php-5.3.29/lib/php/:/srv/php-5.3.29/bin/$
:435,435s/expose_php = On/expose_php = Off/
:465,465s/memory_limit = 128M/memory_limit = 16M/
:796,796s!;include_path = ".:/php/includes"!include_path = ".:/srv/php-5.3.29/lib/php:/srv/php-5.3.29/share"!
:854,854s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=1/
:891,891s/upload_max_filesize = 2M/upload_max_filesize = 3M/
:1008,1008s$;date.timezone =$date.timezone = Asia/Hong_Kong$
:1490,1490s:;session.save_path = "/tmp":session.save_path = "/dev/shm":
:1508,1508s/session.name = PHPSESSID/session.name = JSESSIONID/
:wq
EOF

cd ..

/srv/php-5.3.29/bin/pecl install redis
cat > /srv/php-5.3.29/etc/conf.d/redis.ini <<EOF
extension=redis.so
EOF

# 如果安装 ZendOptimizer 或 ZendGuardLoader 需要 --with-mpm=prefork
wget http://downloads.zend.com/guard/5.5.0/ZendGuardLoader-php-5.3-linux-glibc23-x86_64.tar.gz
tar zxf ZendGuardLoader-php-5.3-linux-glibc23-x86_64.tar.gz
cp -r ZendGuardLoader-php-5.3-linux-glibc23-x86_64 /srv/
cat > /srv/php-5.3.29/etc/conf.d/zend.ini <<EOF
[Zend]
zend_extension=/srv/ZendGuardLoader-php-5.3-linux-glibc23-x86_64/php-5.3.x/ZendGuardLoader.so
zend_extension_ts=/srv/ZendGuardLoader-php-5.3-linux-glibc23-x86_64/php-5.3.x/ZendGuardLoader.so
EOF

#php -r 'phpinfo();' |grep apc
#php -v | grep Optimizer
#php -m | grep Optimizer
#php -i | grep Zend




