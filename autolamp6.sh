#!/bin/bash
#================================================================================
# LAMP Installing script by Neo <openunix@163.com>
# http://netkiller.sourceforge.net/
# $Id$
#================================================================================
SRC_DIR=$(pwd)
PREFIX_DIR=/srv
EMAIL=webmaster@example.com
#================================================================================
HTTPD_SRC='httpd-2.2.21.tar.gz'
PHP_SRC='php-5.3.8.tar.gz'
MYSQL_SRC='mysql-5.5.9.tar.gz'
MYSQL_LIBS_SRC='mysql-5.1.50.tar.gz'
MYSQL_BIN='mysql-5.1.50-linux-x86_64-glibc23.tar.gz'
JAVA_BIN='jdk-6u20-linux-x64.bin'
#================================================================================
HTTPD_DIR=${HTTPD_SRC%%.tar.gz}
PHP_DIR=${PHP_SRC%%.tar.*}
MYSQL_DIR=${MYSQL_SRC%%.tar.*}
MYSQL_LIBS_DIR=${MYSQL_LIBS_SRC%%.tar.*}
#================================================================================

if [ -z "$( egrep "CentOS|Redhat" /etc/issue)" ]; then
	echo 'Only for Redhat or CentOS'
	exit
fi

function clean(){
        rm -rf $HTTPD_DIR
        rm -rf $PHP_DIR
        rm -rf $MYSQL_DIR
        rm -rf $MYSQL_LIBS_DIR
}

function depend(){
        yum install gcc gcc-c++ make automake autoconf -y
        yum install curl-devel libmcrypt-devel gd-devel libjpeg-devel libpng-devel libXpm-devel libxml2-devel libxslt-devel mhash-devel openldap-devel -y
        yum install ncurses-devel -y
#        yum install mysql-devel -y
        yum install libevent-devel -y
	yum install e4fsprogs -y
	yum install net-snmp-devel -y
	yum install setuptool ntsysv system-config-network-tui -y
	#rpm -Uvh http://download.fedora.redhat.com/pub/epel/5/x86_64/epel-release-5-4.noarch.rpm
}



function httpd(){
rm -rf $HTTPD_DIR
tar zxf $HTTPD_SRC
cd $HTTPD_DIR

RETVAL=$?
[[ $RETVAL != 0 ]] && echo "Static: "$RETVAL &&  exit $?

vim server/mpm/worker/worker.c <<end > /dev/null 2>&1
:%s/#define DEFAULT_SERVER_LIMIT 16/#define DEFAULT_SERVER_LIMIT 256/
:%s/#define DEFAULT_THREAD_LIMIT 64/#define DEFAULT_THREAD_LIMIT 1024/
:wq
end
#define MAX_SERVER_LIMIT 20000
#define MAX_THREAD_LIMIT 20000

[[ $? -ne 0 ]] && echo "Step: server/mpm/worker/worker.c" &&  exit $?

./configure --prefix=$PREFIX_DIR/$HTTPD_DIR \
--with-mpm=worker \
--enable-modules="so dir mime rewrite deflate vhost_alias include" \
--enable-mods-shared="alias filter expires headers  setenvif status info ssl usertrack cache mem-cache file-cache disk-cache version mod_unique_id " \
--disable-authn_file \
--disable-authn_default \
--disable-authz_groupfile \
--disable-authz_user \
--disable-authz_default \
--disable-auth_basic \
--disable-version \
--disable-env \
--disable-autoindex \
--disable-asis \
--disable-cgid \
--disable-cgi \
--disable-negotiation \
--disable-actions \
--disable-userdir \
--enable-so \
--enable-file-cache \
--enable-cache \
--enable-disk-cache \
--enable-mem-cache \
--enable-expires \
--enable-headers \
--enable-ssl \
--enable-info \
--enable-rewrite

#--with-mpm=worker \
#--enable-so \
#--enable-mods-shared=all \
#--disable-alias
#--disable-include \
#--disable-status \

[[ $? -ne 0 ]] && echo "Step: configure" &&  exit $?

make clean
make 

[[ $? -ne 0 ]] && echo "Step: make" &&  exit $?

make install

[[ $? -ne 0 ]] && echo "Step: make install" &&  exit $?

cd ..
ln -s $PREFIX_DIR/$HTTPD_DIR $PREFIX_DIR/httpd
ln -s $PREFIX_DIR/httpd $PREFIX_DIR/apache

cp $PREFIX_DIR/httpd/conf/httpd.conf  $PREFIX_DIR/httpd/conf/httpd.conf.original
mkdir -p /www/logs/error

vim $PREFIX_DIR/httpd/conf/httpd.conf <<end > /dev/null 2>&1
:%s/User daemon/User nobody/
:%s/Group daemon/Group nobody/
:%s/ServerAdmin you@example.com/ServerAdmin $EMAIL/
:%s!#ServerName www.example.com:80!#ServerName www.example.com:80\rServerName 127.0.0.1!
:%s#$PREFIX_DIR/$HTTPD_DIR/htdocs#/www#g 
:%s/#\n    AllowOverride None/#\r    AllowOverride All/
:%s#    DirectoryIndex index.html#    DirectoryIndex index.html index.php#
:%s=    #AddType text/html .shtml=    AddType text/html .shtml=
:%s=    #AddOutputFilter INCLUDES .shtml=    AddOutputFilter INCLUDES .shtml=
:%s=AddOutputFilter INCLUDES .shtml=AddOutputFilter INCLUDES .shtml\r\r    AddType application/x-httpd-php .php .phtml\r    AddType application/x-httpd-php-source .phps\r=
:%s#ErrorLog "logs/error_log"#ErrorLog "| $PREFIX_DIR/httpd/bin/rotatelogs /www/logs/error/error.%Y-%m-%d.log 86400 480"#
:%s=#Include conf/extra/httpd-info.conf=Include conf/extra/httpd-info.conf=
:%s=#Include conf/extra/httpd-mpm.conf=Include conf/extra/httpd-mpm.conf=
:%s=#Include conf/extra/httpd-languages.conf=Include conf/extra/httpd-languages.conf=
:%s=#Include conf/extra/httpd-vhosts.conf=Include conf/extra/httpd-vhosts.conf=
:%s=#Include conf/extra/httpd-default.conf=Include conf/extra/httpd-default.conf=
:wq
end
#:%s!Listen 80!Listen 0.0.0.0:80!
#:%s!#ServerName www.example.com:80!#ServerName www.example.com:80\rServerName *!

#vim $PREFIX_DIR/httpd/conf/extra/httpd-mpm.conf <<end > /dev/null 2>&1
#:%s/<IfModule mpm_worker_module>/<IfModule mpm_worker_module>\r    ServerLimit         16\r    ThreadLimit         128/
#:%s/StartServers          2/StartServers        8/
#:%s/MaxClients          150/MaxClients          2048/
#:%s/MinSpareThreads      25/MinSpareThreads     64/
#:%s/MaxSpareThreads      75/MaxSpareThreads     128/
#:%s/ThreadsPerChild      25/ThreadsPerChild     128/
#:%s/MaxRequestsPerChild   0/MaxRequestsPerChild 10000/
#:wq
#end


vim $PREFIX_DIR/httpd/conf/extra/httpd-mpm.conf <<end > /dev/null 2>&1
:%s/<IfModule mpm_worker_module>/<IfModule mpm_worker_module>\r    ServerLimit         16\r    ThreadLimit         256/
:%s/StartServers          2/StartServers        8/
:%s/MaxClients          150/MaxClients          4096/
:%s/MinSpareThreads      25/MinSpareThreads     64/
:%s/MaxSpareThreads      75/MaxSpareThreads     256/
:%s/ThreadsPerChild      25/ThreadsPerChild     256/
:%s/MaxRequestsPerChild   0/MaxRequestsPerChild 10000/
:wq
end

vim $PREFIX_DIR/httpd/conf/extra/httpd-languages.conf <<end > /dev/null 2>&1
:%s/LanguagePriority en ca cs da de el eo es et fr he hr it ja ko ltz nl nn no pl pt pt-BR ru sv tr zh-CN zh-TW/#LanguagePriority en ca cs da de el eo es et fr he hr it ja ko ltz nl nn no pl pt pt-BR ru sv tr zh-CN zh-TW/
:%s/ForceLanguagePriority Prefer Fallback/#ForceLanguagePriority Prefer Fallback/
:wq
end

echo -ne "
AddDefaultCharset UTF-8
" >> $PREFIX_DIR/httpd/conf/extra/httpd-languages.conf

vim $PREFIX_DIR/httpd/conf/extra/httpd-info.conf <<end > /dev/null 2>&1
:%s/Allow from .example.com/Allow from 127.0.0.1 172.16.1 113.106.63.1/g
:wq
end

vim $PREFIX_DIR/httpd/conf/extra/httpd-default.conf <<end > /dev/null 2>&1
:%s/ServerTokens Full/ServerTokens Prod/
:wq
end

echo -ne "
$PREFIX_DIR/httpd/bin/apachectl start
" >> /etc/rc.local

}
function php(){
#ln -s /usr/lib64/mysql/* /usr/lib64/
#ln -s /srv/mysql/bin/mysql_config /usr/local/bin/

rm -rf $PHP_DIR
tar zxf $PHP_SRC
cd $PHP_DIR

./configure --prefix=$PREFIX_DIR/$PHP_DIR \
--with-config-file-path=$PREFIX_DIR/$PHP_DIR/etc \
--with-config-file-scan-dir=$PREFIX_DIR/$PHP_DIR/etc/conf.d \
--with-apxs2=$PREFIX_DIR/$HTTPD_DIR/bin/apxs \
--with-curl \
--with-gd \
--with-jpeg-dir \
--with-png-dir \
--with-freetype-dir \
--with-xpm-dir \
--with-iconv \
--with-zlib-dir \
--with-xmlrpc \
--with-openssl \
--with-mcrypt \
--with-mhash=shared \
--with-mysql=/srv/mysql-5.1.50-linux-x86_64-glibc23 \
--with-pdo-mysql=/srv/mysql-5.1.50-linux-x86_64-glibc23 \
--with-sqlite=shared \
--with-pdo-sqlite=shared \
--with-ldap=shared \
--with-snmp=shared \
--with-xsl=shared \
--with-pear \
--enable-sockets \
--enable-soap \
--enable-mbstring \
--enable-magic-quotes \
--enable-inline-optimization \
--enable-gd-native-ttf \
--enable-zip \
--enable-xml \
--enable-ftp 

#--with-mysqli=/srv/mysql-5.1.50-linux-x86_64-glibc23/bin/mysql_config \
#--enable-embedded-mysqli \

#--enable-fpm \
#--with-fpm-user=nobody \
#--with-fpm-group=nobody \
#--with-mysql=/srv/mysql-5.5.9-linux2.6-x86_64 \
#--with-pdo-mysql=/srv/mysql-5.5.9-linux2.6-x86_64 \

[[ $? -ne 0 ]] && echo "Step: configure" &&  exit $?

#make && make test && make install
#make &&  make install
make
[[ $? -ne 0 ]] && echo "Step: make" &&  exit $?

make install
[[ $? -ne 0 ]] && echo "Step: make install" &&  exit $?

mkdir -p $PREFIX_DIR/$PHP_DIR/etc/conf.d
cp $PREFIX_DIR/src/$PHP_DIR/php.ini-production $PREFIX_DIR/$PHP_DIR/etc/php.ini
ln -s $PREFIX_DIR/$PHP_DIR $PREFIX_DIR/php

cp $PREFIX_DIR/$PHP_DIR/etc/php.ini $PREFIX_DIR/$PHP_DIR/etc/php.ini.original

vim $PREFIX_DIR/php/etc/php.ini <<EOF > /dev/null 2>&1
:%s!;include_path = ".:/php/includes"!;include_path = ".:/php/includes"\rinclude_path = ".:$PREFIX_DIR/$PHP_DIR/lib/php"!
:%s:;extension_dir = "./":extension_dir = "$PREFIX_DIR/$PHP_DIR/lib/php/extensions":
:%s/memory_limit = 128M/memory_limit = 64M/
:%s/log_errors = Off/log_errors = On/
:%s#;error_log = php_errors.log#error_log = php_errors.log#
:%s#;open_basedir =#open_basedir = /www/:/tmp/#
:%s/upload_max_filesize = 2M/upload_max_filesize = 8M/
:wq
EOF

#:%s/mysql.allow_persistent = On/mysql.allow_persistent = Off/
#:%s/register_long_arrays = On/register_long_arrays = Off/
#:%s/display_errors = On/display_errors = Off/
#:%s/output_buffering = Off/output_buffering = On/
#:%s/allow_call_time_pass_reference = On/allow_call_time_pass_reference = Off/
#:%s#;error_log = php_errors.log#error_log = /www/logs/php_errors.log#


    read -p "php memcache module? [y/n]" -n 1 key
    echo
    if [ $key = 'y' ]; then
$PREFIX_DIR/php/bin/pecl install memcache
cp $PREFIX_DIR/$PHP_DIR/lib/php/extensions/no-debug-zts-*/memcache.so $PREFIX_DIR/$PHP_DIR/lib/php/extensions/
cat > $PREFIX_DIR/php/etc/conf.d/memcache.ini <<EOF
extension=memcache.so
EOF
#> /dev/null 2>&1
#memcache.default_timeout_ms=30
    fi

    read -p "php APC module? [y/n]" -n 1 key
    echo
    if [ $key = 'y' ]; then
$PREFIX_DIR/php/bin/pecl install apc
cp $PREFIX_DIR/$PHP_DIR/lib/php/extensions/no-debug-zts-*/apc.so $PREFIX_DIR/$PHP_DIR/lib/php/extensions/
cat > $PREFIX_DIR/php/etc/conf.d/apc.ini <<EOF
extension=apc.so
EOF
# > /dev/null 2>&1

    fi
}

function mysql(){
rm -rf $MYSQL_DIR
tar zxf $MYSQL_SRC
cd $MYSQL_DIR
./configure \
--prefix=$PREFIX_DIR/$MYSQL_DIR \
--with-mysqld-user=mysql \
--with-unix-socket-path=/tmp/mysql.sock \
--with-charset=utf8 \
--with-collation=utf8_general_ci
--with-extra-charsets=complex \
--with-big-tables \
--with-readline \
--with-ssl \
--with-embedded-server \
--with-plugins=innobase \
--with-mysqld-user=mysql \
--without-ndb-debug \
--without-debug \
--without-bench
--without-docs \
--localstatedir=/data/mysql/data \
--enable-assembler \
--enable-thread-safe-client \
--enable-local-infile \

make clean
make && make install
cd ..

ln -s $PREFIX_DIR/$MYSQL_DIR $PREFIX_DIR/mysql
$PREFIX_DIR/$MYSQL_DIR/bin/mysql_install_db --user=mysql
chown mysql.mysql -R $PREFIX_DIR/$MYSQL_DIR
cp $PREFIX_DIR/src/$MYSQL_DIR/support-files/mysql.server /etc/init.d/mysql
/etc/init.d/mysql start
$PREFIX_DIR/$MYSQL_DIR/bin/mysqladmin -u root password '9S5wxCVPMY'
}


function java(){
	JAVA_DIR=${JAVA_BIN%%.bin}
        #yum install java-1.6.0-openjdk -y
        chmod +x $JAVA_BIN
        ./$JAVA_BIN
        mv $JAVA_DIR ..
        ln -s $PREFIX_DIR/$JAVA_DIR $PREFIX_DIR/java
echo -ne '
export JAVA_HOME=$PREFIX_DIR/java
export CLASSPATH=$JAVA_HOME/lib:$JAVA_HOME/jre/lib:$CLASSPATH
export PATH=$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$HOMR/bin:$PATH
export PATH=$PATH:$PREFIX_DIR/httpd/bin:$PREFIX_DIR/php/bin:$PREFIX_DIR/mysql/bin:$PREFIX_DIR/resin/bin:$PREFIX_DIR/python/bin
' >> /etc/profile

}
function resin(){
        tar zxf resin-4.0.6.tar.gz
        mv resin-4.0.6 $PREFIX_DIR/
	echo 'export RESIN_HOME=$PREFIX_DIR/resin' >> /etc/profile
}
function memcache(){
        MEMCACHED_PKG=memcached-1.4.5.tar.gz
        MEMCACHED_SRC=memcached-1.4.5
        rm -rf $MEMCACHED_SRC
        tar zxf $MEMCACHED_PKG
        cd $MEMCACHED_SRC
        ./configure --prefix=$PREFIX_DIR/memcached-1.4.5
        make && make install
}



function vsftpd(){
	yum install -y vsftpd
	adduser --home-dir /www/target/logs/ --shell /sbin/nologin --password logs.xiu.com logs
	echo logs >> /etc/vsftpd/chroot_list
	vim /etc/vsftpd/vsftpd.conf <<VIM > /dev/null 2>&1
:%s/#chroot_list_enable=YES/chroot_list_enable=YES/
:%s/#chroot_list_file/chroot_list_file/
VIM
	chkconfig vsftpd on
	service vsftpd start
}


# See how we were called.
case "$1" in
  clean)
        clean
        ;;
  httpd)
        httpd
        ;;
  php)
        php
        ;;
  mysql)
        if [ -f $0 ] ; then
                mysql
        fi
        ;;
  depend)
        depend
        ;;
  java)
        java
        ;;
  resin)
        resin
        ;;
  profile)
        profile
        ;;
  memcache)
        memcache
        ;;
  lamp)
        clean

        echo ##################################################
        echo # $MYSQL_DIR Installing...
        echo ##################################################
        mysql

        echo ##################################################
        echo # $HTTPD_DIR Installing...
        echo ##################################################
        httpd

        echo ##################################################
        echo # $PHP_DIR Installing...
        echo ##################################################
        php

        clean
        ;;
  vsftpd)
	vsftpd
	;;
  optimization)
	optimization
	;;
  *)
        echo $"Usage: $0 {depend|clean}"
        echo "		{httpd|php|mysql|vsftpd}"
        echo "		{java|resin}"
        echo "		{memcache}"
        echo "		{optimization}"
        echo "		{ntp|snmp|nagios|nrpe}"
        RETVAL=2
        ;;
esac

exit $RETVAL

