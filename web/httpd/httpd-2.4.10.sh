#!/bin/bash

PREFIX_DIR=/srv
HTTPD_DIR=$HTTPD_DIR/httpd-2.4.10

#yum install -y apr apr-util 
yum -y install pcre-devel openssl-devel

cd /usr/local/src/
wget http://apache.01link.hk/apr/apr-1.5.1.tar.bz2
wget http://apache.01link.hk/apr/apr-util-1.5.4.tar.bz2
wget http://apache.communilink.net//httpd/httpd-2.4.10.tar.bz2

tar jxf apr-1.5.1.tar.bz2
cd apr-1.5.1
./configure --prefix=/srv/apr-1.5.1 && make && make install

cd ..

tar jxf apr-util-1.5.4.tar.bz2 
cd apr-util-1.5.4
./configure --prefix=/srv/apr-util-1.5.4 --with-apr=/srv/apr-1.5.1 && make && make install

cd ..

tar jxf httpd-2.4.10.tar.bz2
cd httpd-2.4.10

./configure --prefix=/srv/httpd-2.4.10 \
--with-apr=/srv/apr-1.5.1 \
--with-apr-util=/srv/apr-util-1.5.4 \
--with-mpm=event \
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

# 如果安装 ZendOptimizer 或 ZendGuardLoader 需要 --with-mpm=prefork

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

#--enbale-mpms-shared=all 
#--enable-modules="so dir mime rewrite deflate expires vhost_alias include" \
#--enable-mods-shared="alias filter headers setenvif status info ssl usertrack cache mem-cache file-cache disk-cache version mod_unique_id proxy proxy-connect proxy-http proxy-fcgi proxy-scgi proxy-balancer proxy-express" \

#--enable-proxy-ftp \
#--enable-proxy-fdpass \
#--enable-proxy-ajp \

#--enable-session \
#--enable-session-cookie \
#--enable-session-crypto \
#--enable-session-dbd 

make -j8 && make install

ln -sv /srv/httpd-2.4.10 /srv/httpd

cp /srv/httpd-2.4.10/conf/httpd.conf{,.original}
vim /srv/httpd-2.4.10/conf/httpd.conf <<VIM > /dev/null 2>&1
:171,171s/^$/ServerName localhost:80/
:453,453s/#//
:wq
VIM

#:444,444s/#//

cp /srv/httpd-2.4.10/conf/mime.types{,.original}
cat >> /srv/httpd-2.4.10/conf/mime.types <<EOF

application/x-httpd-php             php
application/x-httpd-php-source      phps
EOF

cp /srv/httpd-2.4.10/conf/extra/httpd-default.conf{,.original}
sed -i "s/ServerTokens Full/ServerTokens Prod/" /srv/httpd-2.4.10/conf/extra/httpd-default.conf

cat >> /etc/man.config <<EOF
MANPATH  /srv/httpd/man/
EOF

cat >> /etc/profile.d/http.sh <<EOF
export PATH=/srv/httpd/bin:$PATH
EOF

sed "2i#\n# chkconfig: 35 85 35" /srv/httpd-2.4.10/bin/apachectl > /etc/init.d/httpd
chmod +x /etc/init.d/httpd
chkconfig --add httpd

iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT