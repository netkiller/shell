#!/bin/bash

cd /usr/local/src/

dnf install -y curl-devel libmcrypt-devel mhash-devel gd-devel libjpeg-devel libpng-devel libXpm-devel libxml2-devel libxslt-devel openssl-devel recode-devel 
#dnf install openldap-devel net-snmp-devel

dnf localinstall -y http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm
dnf install mysql-community-devel -y

wget http://museum.php.net/php5/php-5.2.17.tar.gz
tar zxf php-5.2.17.tar.gz
cd php-5.2.17

./configure --prefix=/srv/php-5.2.17 \
--with-config-file-path=/srv/php-5.2.17/etc \
--with-config-file-scan-dir=/srv/php-5.2.17/etc/conf.d \
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
--disable-debug

#--enable-sysvsem \
#--enable-sysvshm \
#--enable-sysvmsg \
#--enable-pcntl \
#--with-tsrm-pthreads \

make -j8 && make install

mkdir -p /srv/php-5.2.17/etc/conf.d/
cp php.ini-* /srv/php-5.2.17/etc/
cp php.ini-recommended /srv/php-5.2.17/etc/php.ini
cp /srv/php-5.2.17/etc/pear.conf{,.original}

strip /srv/php-5.2.17/bin/php

ln -s /srv/php-5.2.17/ /srv/php

cat >> /etc/man.config <<EOF
MANPATH  /srv/php/man/
EOF

cat >> /etc/profile.d/php.sh <<EOF
export PATH=/srv/php/bin:$PATH
EOF

vim /srv/php-5.2.17/etc/php.ini <<EOF > /dev/null 2>&1
:254,254s$;open_basedir =$open_basedir = /www/:/tmp/:/var/tmp/:/srv/php-5.2.17/lib/php/:/srv/php-5.2.17/bin/:/srv/httpd/htdocs/$
:297,297s/expose_php = On/expose_php = Off/
:307,307s/memory_limit = 128M/memory_limit = 16M/
:496,496s/magic_quotes_gpc = Off/magic_quotes_gpc = On/
:499,499s/magic_quotes_runtime = Off/magic_quotes_runtime = On/
:525,525s!;include_path = ".:/php/includes"!include_path = ".:/srv/php-5.2.17/lib/php:/srv/php-5.2.17/share"!
:542,542s:extension_dir = "./":extension_dir = "/srv/php-5.2.17/lib/php/extensions/no-debug-non-zts-20060613":
:571,571s/; cgi.fix_pathinfo=1/cgi.fix_pathinfo=1/
:716,716s:;date.timezone =:date.timezone = Asia/Hong_Kong:
:1046,1046s:;session.save_path = "/tmp":session.save_path = "/dev/shm":
:1058,1058s/session.name = PHPSESSID/session.name = JSESSIONID/
:wq
EOF

#:%s/upload_max_filesize = 2M/upload_max_filesize = 8M/

cd ..

/srv/php-5.2.17/bin/pecl install redis
cat > /srv/php-5.2.17/etc/conf.d/redis.ini <<EOF
extension=redis.so
EOF

# 安装 ZendOptimizer 需要 --with-mpm=prefork
wget http://downloads.zend.com/optimizer/3.3.9/ZendOptimizer-3.3.9-linux-glibc23-x86_64.tar.gz
tar zxf ZendOptimizer-3.3.9-linux-glibc23-x86_64.tar.gz
mv ZendOptimizer-3.3.9-linux-glibc23-x86_64 /srv/
cat > /srv/php-5.2.17/etc/conf.d/zend.ini <<EOF
[Zend]
zend_extension=/srv/ZendOptimizer-3.3.9-linux-glibc23-x86_64/data/5_2_x_comp/ZendOptimizer.so
zend_extension_ts=/srv/ZendOptimizer-3.3.9-linux-glibc23-x86_64/data/5_2_x_comp/ZendOptimizer.so
EOF

# 安装 ZendOptimizer 需要 --with-mpm=prefork, 但ZendOptimizer-3.3.3在--with-mpm=event 模式下可以安装，ZendOptimizer-3.3.9 不支持event
wget http://downloads.zend.com/optimizer/3.3.3/ZendOptimizer-3.3.3-linux-glibc23-x86_64.tar.gz
tar zxvf ZendOptimizer-3.3.3-linux-glibc23-x86_64.tar.gz
cp -r ZendOptimizer-3.3.3-linux-glibc23-x86_64 /srv/
cat > /srv/php-5.2.17/etc/conf.d/zend.ini <<EOF
[Zend]
zend_extension=/srv/ZendOptimizer-3.3.3-linux-glibc23-x86_64/data/5_2_x_comp/ZendOptimizer.so
zend_extension_ts=/srv/ZendOptimizer-3.3.3-linux-glibc23-x86_64/data/5_2_x_comp/TS/ZendOptimizer.so
EOF

#/srv/php-5.2.17/bin/pecl install apc
#cat > /srv/php-5.2.17/etc/conf.d/apc.ini <<EOF
#extension=apc.so
#EOF

#php -r 'phpinfo();' |grep apc

#php -v | grep Optimizer
#php -m | grep Optimizer
#php -i | grep Zend




