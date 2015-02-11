#!/bin/bash
# yum 与 apt 版本过低所以需要编译安装

curl -s https://raw.githubusercontent.com/oscm/shell/master/compiler/gcc.sh | bash

curl -s https://raw.githubusercontent.com/oscm/shell/master/web/httpd/httpd.yum.sh | bash

yum install -y openssl-devel gd-devel
#mail command
yum install -y mailx

cd /usr/local/src
wget http://softlayer-sng.dl.sourceforge.net/project/nagios/nagios-4.x/nagios-4.0.8/nagios-4.0.8.tar.gz
wget http://nagios-plugins.org/download/nagios-plugins-2.0.3.tar.gz
wget http://liquidtelecom.dl.sourceforge.net/project/nagios/nrpe-2.x/nrpe-2.15/nrpe-2.15.tar.gz
tar zxf nagios-4.0.8.tar.gz
tar zxf nagios-plugins-2.0.3.tar.gz
tar zxf nrpe-2.15.tar.gz

useradd -s /sbin/nologin -d /srv/nagios nagios
usermod -G nagios apache

cd nagios-4.0.8
./configure --prefix=/srv/nagios-4.0.8
make all && make install && make install-init && make install-commandmode && make install-config && make install-webconf
# && make install-exfoliation && make install-classicui

cd /usr/local/src

cd nagios-plugins-2.0.3
./configure --prefix=/srv/nagios-4.0.8 --with-nagios-user=nagios --with-nagios-group=nagios
make -j8 && make install

cd /usr/local/src

cd nrpe-2.15
./configure --prefix=/srv/nagios-4.0.8
make all && make install-plugin
# nrpe server 安装完毕， 下面是client 可以不安装。
#make install-daemon
#make install-daemon-config
#make install-xinetd

cd /usr/local/src

cat >> /etc/services <<EOD

nrpe            5666/tcp                # NRPE
EOD

ln -s /srv/nagios-4.0.8 /srv/nagios

chkconfig --add nagios
chkconfig nagios on
chkconfig --list nagios

wget https://raw.githubusercontent.com/oscm/shell/master/monitor/nagios/media/warning.wav -O /srv/nagios-4.0.8/share/media/warning.wav
wget https://raw.githubusercontent.com/oscm/shell/master/monitor/nagios/media/critical.wav -O /srv/nagios-4.0.8/share/media/critical.wav
wget https://raw.githubusercontent.com/oscm/shell/master/monitor/nagios/media/hostdown.wav -O /srv/nagios-4.0.8/share/media/hostdown.wav

systemctl restart httpd

htpasswd -c /srv/nagios-4.0.8/etc/htpasswd.users nagiosadmin
chown apache:apache /srv/nagios-4.0.8/etc/htpasswd.users
chmod 600 /srv/nagios-4.0.8/etc/htpasswd.users

cp /srv/nagios-4.0.8/etc/nagios.cfg{,.original}
cp /srv/nagios-4.0.8/etc/cgi.cfg{,.original}
#cp /srv/nagios-4.0.8/etc/objects/commands.cfg{,.original}

# cfg_dir
sed -i "51,51s/#//" /srv/nagios-4.0.8/etc/nagios.cfg
mkdir /srv/nagios-4.0.8/etc/servers

# enable audio files
vim /srv/nagios-4.0.8/etc/cgi.cfg <<VIM > /dev/null 2>&1
:312,317s/#//g
:wq
VIM


cat > /etc/profile.d/nagios.sh <<EOD
export PATH=$PATH:/srv/nagios/bin:/srv/nagios/libexec
EOD
