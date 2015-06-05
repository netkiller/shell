#!/bin/bash

#yum install -y openssh-clients
#rpm -Uvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-2.noarch.rpm
yum localinstall -y http://ftp.cuhk.edu.hk/pub/linux/fedora-epel/7/x86_64/e/epel-release-7-5.noarch.rpm

yum remove -y dhclient dhcp-*
yum install -y telnet wget rsync vim-enhanced
yum install -y net-tools

yum update -y

cat > /etc/security/limits.d/20-nofile.conf <<EOF

* soft nofile 4096
* hard nofile 4096

www soft nofile 65535
www hard nofile 65535

nginx soft nofile 65535
nginx hard nofile 65535

mysql soft nofile 65535
mysql hard nofile 65535

redis soft nofile 65535
redis hard nofile 65535

rabbitmq soft nofile 4096
rabbitmq hard nofile 40960
EOF

cat >> /etc/sysctl.conf <<EOF

net.ipv4.ip_local_port_range = 1024 65500
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_tw_recycle = 1
net.ipv4.tcp_keepalive_time = 1800
net.core.netdev_max_backlog=3000
net.ipv4.tcp_max_syn_backlog = 8192
net.ipv4.tcp_max_tw_buckets = 4096
net.core.somaxconn = 1024
EOF
#net.ipv4.tcp_syncookies = 1
#net.ipv4.tcp_fin_timeout = 60

sysctl -p

cat >> /etc/bashrc <<EOF
# Administrator specific aliases and functions for system security
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "
EOF
