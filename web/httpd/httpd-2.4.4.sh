#!/bin/bash

PREFIX_DIR=/srv
HTTPD_DIR=$HTTPD_DIR/httpd-2.4.4

#dnf install -y apr apr-util 
dnf -y install pcre-devel openssl-devel

cd /usr/local/src/
wget http://apache.01link.hk/apr/apr-1.4.6.tar.gz
wget http://apache.01link.hk/apr/apr-util-1.5.2.tar.gz
wget http://ftp.cuhk.edu.hk/pub/packages/apache.org/httpd/httpd-2.4.4.tar.gz

tar zxf apr-1.4.6.tar.gz 
cd apr-1.4.6
./configure --prefix=/srv/apr-1.4.6 && make && make install

cd ..

tar zxf apr-util-1.5.2.tar.gz 
cd apr-util-1.5.2
./configure --prefix=/srv/apr-util-1.5.2 --with-apr=/srv/apr-1.4.6 && make && make install

cd ..

tar zxf httpd-2.4.4.tar.gz 
cd httpd-2.4.4

./configure --prefix=/srv/httpd-2.4.4 \
--with-mpm=event \
--with-apr=/srv/apr-1.4.6 \
--with-apr-util=/srv/apr-util-1.5.2 \
--enable-mods-static="so dir mime rewrite deflate expires vhost_alias include ssl status" \
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
--disable-version \
--enable-so \
--enable-deflate \
--enable-expires \
--enable-headers \
--enable-ssl \
--enable-rewrite \
--enable-include \
--enable-remoteip \
--enable-ratelimit

#--enable-info \

#--enable-cache \
#--enable-file-cache \
#--enable-disk-cache \
#--enable-mem-cache \

#--enable-proxy \
#--enable-proxy-connect  \
#--enable-proxy-http \
#--enable-proxy-fcgi \
#--enable-proxy-scgi \
#--enable-proxy-balancer \
#--enable-proxy-express

#--enable-modules="so dir mime rewrite deflate expires vhost_alias include" \
#--enable-mods-shared="alias filter headers setenvif status info ssl usertrack cache mem-cache file-cache disk-cache version mod_unique_id proxy proxy-connect proxy-http proxy-fcgi proxy-scgi proxy-balancer proxy-express" \

#--enable-proxy-ftp \
#--enable-proxy-fdpass \
#--enable-proxy-ajp \

#--enable-session \
#--enable-session-cookie \
#--enable-session-crypto \
#--enable-session-dbd 

make && make install

ln -sv /srv/httpd-2.4.4 /srv/httpd

vim /srv/httpd-2.4.4/conf/httpd.conf <<VIM > /dev/null 2>&1
s/#ServerName www.example.com:80/ServerName localhost:80/
:450,450s/#//
:wq
VIM

cat >> /srv/httpd-2.4.4/conf/mime.types <<EOF

application/x-httpd-php             php
application/x-httpd-php-source      phps
EOF
 

sed -i "s/ServerTokens Full/ServerTokens Prod/" /srv/httpd-2.4.4/conf/extra/httpd-default.conf

sed "2i#\n# chkconfig: 35 85 35" /srv/httpd-2.4.4/bin/apachectl > /etc/init.d/httpd
chmod +x /etc/init.d/httpd
chkconfig --add httpd

iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT