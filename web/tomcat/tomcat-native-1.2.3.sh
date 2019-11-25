#!/bin/bash

dnf install -y openssl-devel
#apr-devel

cd /usr/local/src/
wget http://apache.01link.hk//apr/apr-1.5.2.tar.bz2
tar jxf apr-1.5.2.tar.bz2
cd apr-1.5.2/

# Fixed bug
sed -i '30206s/$RM "$cfgfile"/$RM -f "$cfgfile"/' configure

./configure --prefix=/srv/apr-1.5.2
make -j8
make install

cd /usr/local/src/
wget http://apache.01link.hk//apr/apr-util-1.5.4.tar.bz2
tar jxf apr-util-1.5.4.tar.bz2
cd apr-util-1.5.4/
./configure --prefix=/srv/apr-util-1.5.4 --with-apr=/srv/apr-1.5.2
# --with-apr-iconv= 
make -j8
make install

cd /usr/local/src/
wget http://apache.01link.hk/tomcat/tomcat-connectors/native/1.2.3/source/tomcat-native-1.2.3-src.tar.gz
tar zxvf tomcat-native-1.2.3-src.tar.gz
cd tomcat-native-1.2.3-src/native
./configure --prefix=/srv/apache-tomcat --with-apr=/srv/apr-1.5.2/bin/apr-1-config --with-ssl=yes  --with-java-home=/srv/jdk
make -j8
make install


cat > /etc/ld.so.conf.d/tomcat-native.conf <<EOF
/srv/apache-tomcat/lib
EOF