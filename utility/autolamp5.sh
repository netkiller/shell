#!/bin/bash
#================================================================================
# LAMP Installing script by Neo <openunix@163.com>
# http://netkiller.sourceforge.net/
# $Id$
#================================================================================
SRC_DIR=$(pwd)
PREFIX_DIR=/srv
EMAIL=webmaster@example.com
HTTPD_SRC=httpd-2.2.17.tar.gz
PHP_SRC=php-5.2.17.tar.gz
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
        yum install gcc gcc-c++ make autoconf -y
        yum install curl-devel libmcrypt-devel gd-devel libjpeg-devel libpng-devel libXpm-devel libxml2-devel libxslt-devel mhash-devel openldap-devel -y
        yum install ncurses-devel -y
#        yum install mysql-devel -y
        yum install libevent-devel -y
	
	yum install e4fsprogs -y
	yum install net-snmp-devel -y
	yum install setuptool ntsysv system-config-network-tui -y
	rpm -Uvh http://download.fedora.redhat.com/pub/epel/5/x86_64/epel-release-5-4.noarch.rpm
}

function tools(){
	yum install wget telnet tcpdump -y
}
function ntp(){
	yum install ntp -y
	ntpdate 172.16.1.10

vim /etc/ntp.conf <<VIM > /dev/null 2>&1
:17,17s/^/server 172.16.1.10\r/
:wq
VIM

	service ntpd start
	chkconfig ntpd on
}
function snmp (){
	yum install net-snmp -y

vim /etc/snmp/snmpd.conf <<VIM > /dev/null 2>&1
:62,62s/systemview/all/
:85,85s/^#//
:wq
VIM

	service snmpd start
	chkconfig snmpd on
}


function httpd(){
rm -rf $HTTPD_DIR
tar zxf $HTTPD_SRC
cd $HTTPD_DIR

vim server/mpm/worker/worker.c <<end > /dev/null 2>&1
:%s/#define DEFAULT_SERVER_LIMIT 16/#define DEFAULT_SERVER_LIMIT 256/
:%s/#define DEFAULT_THREAD_LIMIT 64/#define DEFAULT_THREAD_LIMIT 1024/
:wq
end

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

make clean
make && make install
cd ..
ln -s $PREFIX_DIR/$HTTPD_DIR $PREFIX_DIR/httpd
ln -s $PREFIX_DIR/httpd $PREFIX_DIR/apache

cp $PREFIX_DIR/httpd/conf/httpd.conf  $PREFIX_DIR/httpd/conf/httpd.conf.old
mkdir -p /www/logs/error

vim $PREFIX_DIR/httpd/conf/httpd.conf <<end > /dev/null 2>&1
:%s/User daemon/User nobody/
:%s/Group daemon/Group nobody/
:%s/ServerAdmin you@example.com/ServerAdmin $EMAIL/
:%s!#ServerName www.example.com:80!#ServerName www.example.com:80\rServerName *!
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
:wq
end

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


echo -ne "
$PREFIX_DIR/httpd/bin/apachectl start
" >> /etc/rc.local

}
function php(){
#configure: error: Cannot find MySQL header files under
#ln -s $PREFIX_DIR/mysql-5.1.45/bin/mysql_config $PREFIX_DIR/bin/
#rm -rf $MYSQL_LIBS_DIR
#tar zxf $MYSQL_LIBS_SRC
# or
# rpm -ivh MySQL-devel-5.1.50-1.glibc23.x86_64.rpm
# rpm -ivh MySQL-shared-5.1.50-1.glibc23.x86_64.rpm

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
--with-ldap=shared \
--with-openssl \
--with-mcrypt \
--with-mhash=shared \
--with-mysql=/srv/mysql-5.1.50-linux-x86_64-glibc23 \
--with-mysqli=/srv/mysql-5.1.50-linux-x86_64-glibc23/bin/mysql_config \
--with-pdo-mysql=/srv/mysql-5.1.50-linux-x86_64-glibc23 \
--with-sqlite=shared \
--with-pdo-sqlite=shared \
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

#--enable-fpm \
#--with-fpm-user=nobody \
#--with-fpm-group=nobody \
#--with-mysql=/srv/mysql-5.5.9-linux2.6-x86_64 \
#--with-pdo-mysql=/srv/mysql-5.5.9-linux2.6-x86_64 \

#make && make test && make install
make &&  make install
cp $PREFIX_DIR/src/$PHP_DIR/php.ini-dist $PREFIX_DIR/$PHP_DIR/etc/php.ini
ln -s $PREFIX_DIR/$PHP_DIR $PREFIX_DIR/php

cp $PREFIX_DIR/$PHP_DIR/etc/php.ini $PREFIX_DIR/$PHP_DIR/etc/php.ini.original

vim $PREFIX_DIR/php/etc/php.ini <<EOF > /dev/null 2>&1
:%s!;include_path = ".:/php/includes"!;include_path = ".:/php/includes"\rinclude_path = ".:$PREFIX_DIR/$PHP_DIR/lib/php"!
:%s:extension_dir = "./":extension_dir = "$PREFIX_DIR/$PHP_DIR/lib/php/extensions":
:%s/output_buffering = Off/output_buffering = On/
:%s/memory_limit = 128M/memory_limit = 64M/
:%s/display_errors = On/display_errors = Off/
:%s/log_errors = Off/log_errors = On/
:%s#;error_log = filename#error_log = /www/logs/php_error.log#
:%s/register_long_arrays = On/register_long_arrays = Off/
:%s#;open_basedir = #open_basedir = /www/:/tmp/#
:%s/upload_max_filesize = 2M/upload_max_filesize = 8M/
:%s/mysql.allow_persistent = On/mysql.allow_persistent = Off/
:wq
EOF
#:%s/allow_call_time_pass_reference = On/allow_call_time_pass_reference = Off/
#:%s#;error_log = php_errors.log#error_log = /www/logs/php_errors.log#


    read -p "php memcache module? [y/n]" -n 1 key
    echo
    if [ $key = 'y' ]; then
$PREFIX_DIR/php/bin/pecl install memcache
cp $PREFIX_DIR/$PHP_DIR/lib/php/extensions/no-debug-zts-*/memcache.so $PREFIX_DIR/$PHP_DIR/lib/php/extensions/
vim $PREFIX_DIR/php/etc/php.ini <<EOF > /dev/null 2>&1
:%s#;extension=php_zip.dll#;extension=php_zip.dll\rextension=memcache.so#
:wq
EOF
#	echo 'memcache.default_timeout_ms=30' >> $PREFIX_DIR/php/etc/php.ini
    fi

    read -p "php APC module? [y/n]" -n 1 key
    echo
    if [ $key = 'y' ]; then
$PREFIX_DIR/php/bin/pecl install apc
cp $PREFIX_DIR/$PHP_DIR/lib/php/extensions/no-debug-zts-*/apc.so $PREFIX_DIR/$PHP_DIR/lib/php/extensions/
vim $PREFIX_DIR/php/etc/php.ini <<EOF > /dev/null 2>&1
:%s#;extension=php_zip.dll#;extension=php_zip.dll\rextension=apc.so#
:wq
EOF

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

function optimization(){
    echo >> /etc/profile
    echo "PATH=$PATH:/srv/php/bin:/srv/httpd/bin:/srv/mysql/bin" >> /etc/profile

#vim /etc/profile <<EOF > /dev/null 2>&1
#:31,31s:^:ulimit -SHn 20480 > /dev/null 2>&1\r:
#:wq
#EOF


cat >> /etc/security/limits.conf <<EOF
root 	soft nofile 20480
root 	hard nofile 65536
nobody 	soft nofile 20480
nobody 	hard nofile 65536
EOF

cat >> /etc/sysctl.conf <<EOF
net.ipv4.ip_local_port_range = 1024 65500
net.ipv4.tcp_max_syn_backlog = 8192
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_tw_recycle = 1
net.ipv4.tcp_fin_timeout = 30
net.ipv4.tcp_keepalive_intvl = 30
net.ipv4.tcp_keepalive_probes = 3
net.ipv4.tcp_keepalive_time = 1200
net.ipv4.tcp_max_tw_buckets = 4096
EOF
/sbin/sysctl -p	

#:54,88s/^/#/
#:57,57s/^#//
#:65,65s/^#//
#:68,68s/^#//
#:74,75s/^#//
#:80,80s/^#//
#:83,84s/^#//
#:85,87s/^#//
#:58,58s/^#//

}

function nagios(){
	yum install nagios
}

function nrpe(){
	yum install nrpe -y
	yum install -y nagios-plugins-disk nagios-plugins-load nagios-plugins-ping nagios-plugins-procs nagios-plugins-swap nagios-plugins-users

vim /etc/nagios/nrpe.cfg <<VIM > /dev/null 2>&1
:%s/allowed_hosts=127.0.0.1/allowed_hosts=172.16.1.2/
:wq
VIM

	cat >> /etc/nagios/nrpe.cfg <<EOF

#command[check_http]=/usr/lib64/nagios/plugins/check_http -I 127.0.0.1 -p 80 -u http://www.example.com/index.html
command[check_swap]=/usr/lib64/nagios/plugins/check_swap -w 20% -c 10%
command[check_all_disks]=/usr/lib64/nagios/plugins/check_disk -w 20% -c 10% -e
EOF

	chkconfig nrpe on
	service nrpe start
}


security(){

vim /etc/ssh/sshd_config <<VIM > /dev/null 2>&1
:%s/#PermitRootLogin yes/PermitRootLogin no/
:%s/#AuthorizedKeysFile/AuthorizedKeysFile/
:wq
VIM
/etc/init.d/sshd restart

vim /etc/sudoers <<VIM > /dev/null 2>&1
:86,86s/^# //
:wq!
VIM

vim /etc/group <<VIM > /dev/null 2>&1
:11,11s/$/,neo/
:wq
VIM

}

function sshkey(){

mkdir .ssh
chmod 755 .ssh

cat >> .ssh/authorized_keys <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA3Sqv/BtYR65XoC0B41uyK/ZvPqkS4y8JNYnRGZ8aav5aaYj6xO+/dRATaL2S/soo+i05AFCYtD7xUMKhHrhJ02oLJSEl44WncaHBZig8ballQCX3ug0AS/O0wmmZDdYFw6WSxOL44NC0ZTttsAkXCYhxiKCWWFa0Iq8W/gilBxY8PTNsdz/FoKun9oFdmCh8dMhBOg7qPz+Mumr7cdOro8/kXqXjx8b1l4cieyambYZyam5KFZAv4wKn2Arcga1X4NpVlCLGbCzan8b5vMXcXaAZ+MDMpH3fNRQdUpdFYnC4rKr7ORDhKZGKsev5N1tefPn5BEWYj6Fg2hoWxr0Htw== neo.chen@xiu.com
EOF
chmod 644 .ssh/authorized_keys

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
	ntp
	snmp
	nrpe
	optimization
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
  ntpd)
	ntpd
	;;
  snmp)
	snmp
	;;
  nrpe)
	nrpe
	;;
  nagios)
	nagios
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

