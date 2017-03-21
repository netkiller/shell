#!/bin/bash

cd /usr/local/src/

if [ ! -f php-7.1.3.tar.bz2 ];then
	wget http://php.net/distributions/php-7.1.3.tar.bz2
fi

if [ -s php-7.1.3.tar.bz2 ]; then

tar jxf php-7.1.3.tar.bz2
cd php-7.1.3

./configure --prefix=/srv/php-7.1.3 \
--with-config-file-path=/srv/php-7.1.3/etc \
--with-config-file-scan-dir=/srv/php-7.1.3/etc/conf.d \
--mandir=/srv/php-7.1.3/man \
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
--with-mcrypt \
--with-mhash \
--with-pdo-mysql \
--with-openssl \
--with-xsl \
--with-recode \
--with-tsrm-pthreads \
--enable-calendar \
--enable-soap \
--enable-shmop \
--enable-mbstring \
--enable-exif \
--enable-gd-native-ttf \
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

make -j12

[[ $? -ne 0 ]] && echo "Error: make" &&  exit $?

if [ $(id -u) != "0" ]; then
    sudo make install
else
	make install
fi

[[ $? -ne 0 ]] && echo "Error: make install" &&  exit $?

strip /srv/php-7.1.3/bin/php
strip /srv/php-7.1.3/bin/phpdbg
strip /srv/php-7.1.3/sbin/php-fpm 

mkdir -p /srv/php-7.1.3/etc/{fpm,cli}.d
ln -s /srv/php-7.1.3/etc/fpm.d /srv/php-7.1.3/etc/conf.d
cp /srv/php-7.1.3/etc/pear.conf{,.original}
cp php.ini-* /srv/php-7.1.3/etc/
cp /srv/php-7.1.3/etc/php.ini-production /srv/php-7.1.3/etc/php.ini
cp /srv/php-7.1.3/etc/php.ini-production /srv/php-7.1.3/etc/php-cli.ini
cp /srv/php-7.1.3/etc/php-fpm.conf.default /srv/php-7.1.3/etc/php-fpm.conf
cp /srv/php-7.1.3/etc/php-fpm.d/www.conf.default /srv/php-7.1.3/etc/php-fpm.d/www.conf

yes|cp ./sapi/fpm/php-fpm.service /usr/lib/systemd/system/php-fpm.service 

systemctl enable php-fpm

vim /srv/php-7.1.3/etc/php-fpm.conf <<end > /dev/null 2>&1
:17,17s/;pid/pid/
:24,24s/;error_log/error_log/
:85,85s/;rlimit_files = 1024/rlimit_files = 65536/
:wq
end

vim /srv/php-7.1.3/etc/php-fpm.d/www.conf <<end > /dev/null 2>&1
:107,107s/pm.max_children = 5/pm.max_children = 4096/
:112,112s/pm.start_servers = 2/pm.start_servers = 8/
:117,117s/pm.min_spare_servers = 1/pm.min_spare_servers = 8/
:122,122s/pm.max_spare_servers = 3/pm.max_spare_servers = 16/
:133,133s/;pm.max_requests = 500/pm.max_requests = 1024/
:232,232s/;pm.status_path/pm.status_path/
:244,244s/;ping.path/ping.path/
:249,249s/;ping.response/ping.response/
:330,330s/;request_terminate_timeout = 0/request_terminate_timeout = 30s/
:334,334s/;rlimit_files = 1024/rlimit_files = 40960/
:wq
end

#:15,15s/;//

vim /srv/php-7.1.3/etc/php.ini <<EOF > /dev/null 2>&1
:309,309s$;open_basedir =$open_basedir = /www/:/tmp/:/var/tmp/:/srv/php-7.1.3/lib/php/:/srv/php-7.1.3/bin/$
:374,374s/expose_php = On/expose_php = Off/
:404,404s/memory_limit = 128M/memory_limit = 16M/
:775,775s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=1/
:939,939s:;date.timezone =:date.timezone = Asia/Hong_Kong:
:1355,1355s:;session.save_path = "/tmp":session.save_path = "/dev/shm":
:1381,1381s/session.name = PHPSESSID/session.name = JSESSIONID/
:wq
EOF

# PHP 7.1.3 Abandoned disable_functions
#:299,299s/disable_functions =/disable_functions = ini_set,set_time_limit,set_include_path,passthru,exec,system,chroot,scandir,chgrp,chown,shell_exec,proc_open,proc_get_status,ini_alter,ini_restore,dl,openlog,syslog,readlink,symlink,popepassthru,stream_socket_server,fsocket/
#s/max_execution_time = 30/max_execution_time = 300/g
#:706,706s!;include_path = ".:/php/includes"!include_path = ".:/srv/php-7.1.3/lib/php:/srv/php-7.1.3/share"!
#:728,728s!; extension_dir = "./"!extension_dir = "./:/srv/php-7.1.3/lib/php/extensions:/srv/php-7.1.3/lib/php/extensions/no-debug-non-zts-20121212"!
#:804,804s/upload_max_filesize = 2M/upload_max_filesize = 3M/

vim /srv/php-7.1.3/etc/php-cli.ini <<EOF > /dev/null 2>&1
:%s/memory_limit = 128M/memory_limit = 4G/g
:%s:;error_log = php_errors.log:error_log = php_errors.log:g
:%s:;date.timezone =:date.timezone = Asia/Hong_Kong:g
:wq
EOF

systemctl start php-fpm