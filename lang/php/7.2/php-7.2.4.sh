#!/bin/bash

cd /usr/local/src/

if [ ! -f php-7.2.4.tar.bz2 ];then
	wget http://php.net/distributions/php-7.2.4.tar.bz2
fi

if [ ! -f /usr/bin/bunzip2 ];then
    yum install -y bzip2
fi

if [ -s php-7.2.4.tar.bz2 ]; then

tar jxf php-7.2.4.tar.bz2
cd php-7.2.4

./configure --prefix=/srv/php-7.2.4 \
--with-config-file-path=/srv/php-7.2.4/etc \
--with-config-file-scan-dir=/srv/php-7.2.4/etc/conf.d \
--mandir=/srv/php-7.2.4/man \
--enable-fpm \
--enable-opcache \
--with-fpm-systemd \
--with-fpm-user=www \
--with-fpm-group=www \
--with-fpm-systemd \
--with-fpm-acl \
--disable-cgi \
--with-pear \
--with-curl \
--with-gd \
--with-jpeg-dir \
--with-png-dir \
--with-freetype-dir \
--with-zlib-dir \
--with-iconv \
--with-mhash \
--with-pdo-mysql \
--with-openssl \
--with-xsl \
--with-recode \
--with-tsrm-pthreads \
--enable-mysqlnd \
--enable-calendar \
--enable-soap \
--enable-shmop \
--enable-mbstring \
--enable-exif \
--enable-zip \
--enable-xml \
--enable-bcmath \
--enable-dba \
--enable-wddx \
--enable-shmop \
--enable-sockets \
--enable-sysvsem \
--enable-sysvshm \
--enable-sysvmsg \
--enable-pcntl \
--enable-maintainer-zts \
--disable-ipv6 \
--disable-cgi \
--disable-debug

# --with-mysqli=/usr/bin/mysql_config \
# --with-pdo-pgsql=/usr/pgsql-9.4 \
# --with-mysql-sock=/var/lib/mysql/mysql.sock \

fi

[[ $? -ne 0 ]] && echo "Error: configure" &&  exit $?

make -j$(getconf _NPROCESSORS_ONLN)

[[ $? -ne 0 ]] && echo "Error: make" &&  exit $?

if [ $(id -u) != "0" ]; then
    sudo make install
else
	make install
fi

[[ $? -ne 0 ]] && echo "Error: make install" &&  exit $?

strip /srv/php-7.2.4/bin/php
strip /srv/php-7.2.4/bin/phpdbg
strip /srv/php-7.2.4/sbin/php-fpm

mkdir -p /srv/php-7.2.4/etc/fpm.d
ln -s /srv/php-7.2.4/etc/fpm.d /srv/php-7.2.4/etc/conf.d
ln -s /srv/php-7.2.4/etc/fpm.d /srv/php-7.2.4/etc/cli.d
cp /srv/php-7.2.4/etc/pear.conf{,.original}
cp php.ini-* /srv/php-7.2.4/etc/
cp /srv/php-7.2.4/etc/php.ini-production /srv/php-7.2.4/etc/php.ini
cp /srv/php-7.2.4/etc/php.ini-production /srv/php-7.2.4/etc/php-cli.ini
cp /srv/php-7.2.4/etc/php-fpm.conf.default /srv/php-7.2.4/etc/php-fpm.conf
cp /srv/php-7.2.4/etc/php-fpm.d/www.conf.default /srv/php-7.2.4/etc/php-fpm.d/www.conf

# PHP-FPM Config

vim /srv/php-7.2.4/etc/php-fpm.conf <<end > /dev/null 2>&1
:17,17s/;pid/pid/
:24,24s/;error_log/error_log/
:85,85s/;rlimit_files = 1024/rlimit_files = 65536/
:wq
end

vim /srv/php-7.2.4/etc/php-fpm.d/www.conf <<end > /dev/null 2>&1
:113,113s/pm.max_children = 5/pm.max_children = 4096/
:118,118s/pm.start_servers = 2/pm.start_servers = 8/
:123,123s/pm.min_spare_servers = 1/pm.min_spare_servers = 8/
:128,128s/pm.max_spare_servers = 3/pm.max_spare_servers = 16/
:139,139s/;pm.max_requests = 500/pm.max_requests = 1024/
:238,238s/;pm.status_path/pm.status_path/
:250,250s/;ping.path/ping.path/
:255,255s/;ping.response/ping.response/
:340,340s/;request_terminate_timeout = 0/request_terminate_timeout = 30s/
:344,344s/;rlimit_files = 1024/rlimit_files = 40960/
:wq
end

#:15,15s/;//

vim /srv/php-7.2.4/etc/php.ini <<EOF > /dev/null 2>&1
:309,309s$;open_basedir =$open_basedir = /www/:/tmp/:/var/tmp/:/srv/php-7.2.4/lib/php/:/srv/php-7.2.4/bin/$
:374,374s/expose_php = On/expose_php = Off/
:404,404s/memory_limit = 128M/memory_limit = 16M/
:939,939s#;date.timezone =#date.timezone = Asia/Hong_Kong#
:1020,1020s#pdo_mysql.default_socket=#pdo_mysql.default_socket=/var/lib/mysql/mysql.sock#
:1351,1351s#;session.save_path = "/tmp"#session.save_path = "/dev/shm"#
:1377,1377s/session.name = PHPSESSID/session.name = JSESSIONID/
:wq
EOF

# PHP 7.1.3 Abandoned disable_functions
# :776,776s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=1/
#:299,299s/disable_functions =/disable_functions = ini_set,set_time_limit,set_include_path,passthru,exec,system,chroot,scandir,chgrp,chown,shell_exec,proc_open,proc_get_status,ini_alter,ini_restore,dl,openlog,syslog,readlink,symlink,popepassthru,stream_socket_server,fsocket/
#s/max_execution_time = 30/max_execution_time = 300/g
#:706,706s!;include_path = ".:/php/includes"!include_path = ".:/srv/php-7.2.4/lib/php:/srv/php-7.2.4/share"!
#:728,728s!; extension_dir = "./"!extension_dir = "./:/srv/php-7.2.4/lib/php/extensions:/srv/php-7.2.4/lib/php/extensions/no-debug-non-zts-20121212"!
#:804,804s/upload_max_filesize = 2M/upload_max_filesize = 3M/

vim /srv/php-7.2.4/etc/php-cli.ini <<EOF > /dev/null 2>&1
:%s/memory_limit = 128M/memory_limit = 4G/g
:%s:;error_log = php_errors.log:error_log = php_errors.log:g
:%s:;date.timezone =:date.timezone = Asia/Hong_Kong:g
:wq
EOF

rm -f /srv/php
ln -s /srv/php-7.2.4/ /srv/php

yes|cp ./sapi/fpm/php-fpm.service /usr/lib/systemd/system/php-fpm.service

systemctl daemon-reload
systemctl enable php-fpm
systemctl start php-fpm
