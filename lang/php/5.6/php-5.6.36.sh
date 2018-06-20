#!/bin/bash

cd /usr/local/src/
wget http://cn2.php.net/distributions/php-5.6.36.tar.gz

if [ -s php-5.6.36.tar.gz ]; then

tar zxf php-5.6.36.tar.gz
cd php-5.6.36

./configure --prefix=/srv/php-5.6.36 \
--with-config-file-path=/srv/php-5.6.36/etc \
--with-config-file-scan-dir=/srv/php-5.6.36/etc/conf.d \
--enable-fpm \
--enable-opcache \
--with-fpm-user=www \
--with-fpm-group=www \
--with-fpm-systemd \
--with-fpm-acl \
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
--with-pdo-mysql \
--with-mysqli=/usr/bin/mysql_config \
--with-mysql-sock=/var/lib/mysql/mysql.sock \
--with-openssl \
--with-xsl \
--with-recode \
--with-tsrm-pthreads \
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
--enable-maintainer-zts \
--disable-cgi \
--disable-debug

#--enable-exif \
#--with-pdo-pgsql=/usr/pgsql-9.4 \

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

strip /srv/php-5.6.36/bin/php
strip /srv/php-5.6.36/sbin/php-fpm 

mkdir -p /srv/php-5.6.36/etc/conf.d
mkdir -p /srv/php-5.6.36/etc/fpm.d
cp /srv/php-5.6.36/etc/pear.conf{,.original}
cp php.ini-* /srv/php-5.6.36/etc/
cp /srv/php-5.6.36/etc/php.ini-production /srv/php-5.6.36/etc/php.ini
cp /srv/php-5.6.36/etc/php.ini-production /srv/php-5.6.36/etc/php-cli.ini
cp /srv/php-5.6.36/etc/php-fpm.conf.default /srv/php-5.6.36/etc/php-fpm.conf

#cp /srv/php-5.6.36/etc/php.ini-development /srv/php-5.6.36/etc/php.ini
#cp /srv/php-5.6.36/etc/php.ini-development /srv/php-5.6.36/etc/php-cli.ini

sed -i 's:${prefix}:/srv/php-5.6.36:g' ./sapi/fpm/php-fpm.service
sed -i 's:${exec_prefix}:/srv/php-5.6.36:g' ./sapi/fpm/php-fpm.service
yes|cp ./sapi/fpm/php-fpm.service /etc/systemd/system/php-fpm.service 

systemctl enable php-fpm

vim /srv/php-5.6.36/etc/php-fpm.conf <<end > /dev/null 2>&1
:25,25s/;//
:32,32s/;//
:93,93s/;rlimit_files = 1024/rlimit_files = 65536/
:235,235s/pm.max_children = 5/pm.max_children = 2048/
:240,240s/pm.start_servers = 2/pm.start_servers = 8/
:245,245s/pm.min_spare_servers = 1/pm.min_spare_servers = 8/
:250,250s/pm.max_spare_servers = 3/pm.max_spare_servers = 16/
:261,261s/;pm.max_requests = 500/pm.max_requests = 1024/
:360,360s/;pm.status_path/pm.status_path/
:372,372s/;ping.path/ping.path/
:377,377s/;ping.response/ping.response/
:454,454s/;request_terminate_timeout = 0/request_terminate_timeout = 30s/
:wq
end

#:15,15s/;//
#:458,458s/;rlimit_files = 1024/rlimit_files = 40960/

vim /srv/php-5.6.36/etc/php.ini <<EOF > /dev/null 2>&1
:298,298s$;open_basedir =$open_basedir = /www/:/tmp/:/var/tmp/:/srv/php-5.6.36/lib/php/:/srv/php-5.6.36/bin/$
:363,363s/expose_php = On/expose_php = Off/
:393,393s/memory_limit = 128M/memory_limit = 32M/
:572,572s:;error_log = php_errors.log:error_log = /var/tmp/php_errors.log:
:773,773s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=1/
:926,926s:;date.timezone =:date.timezone = Asia/Hong_Kong:
:1416,1416s:;session.save_path = "/tmp":session.save_path = "/dev/shm":
:1442,1442s/session.name = PHPSESSID/session.name = JSESSIONID/
:wq
EOF

#:303,303s/disable_functions =/disable_functions = ini_set,set_time_limit,set_include_path,passthru,exec,system,chroot,scandir,chgrp,chown,shell_exec,proc_open,proc_get_status,ini_alter,ini_restore,dl,openlog,syslog,readlink,symlink,popepassthru,stream_socket_server,fsocket/
#s/max_execution_time = 30/max_execution_time = 300/g
#:706,706s!;include_path = ".:/php/includes"!include_path = ".:/srv/php-5.6.36/lib/php:/srv/php-5.6.36/share"!
#:728,728s!; extension_dir = "./"!extension_dir = "./:/srv/php-5.6.36/lib/php/extensions:/srv/php-5.6.36/lib/php/extensions/no-debug-non-zts-20121212"!
#:804,804s/upload_max_filesize = 2M/upload_max_filesize = 3M/

vim /srv/php-5.6.36/etc/php-cli.ini <<EOF > /dev/null 2>&1
:393,393s/memory_limit = 128M/memory_limit = 4G/
:572,572s:;error_log = php_errors.log:error_log = /var/tmp/php_errors.cli.log:
:926,926s:;date.timezone =:date.timezone = Asia/Hong_Kong:
:wq
EOF

#:572,572s/;error_log/error_log/

systemctl start php-fpm
