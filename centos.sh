#!/bin/bash

if [ -z "$( egrep "CentOS|Redhat" /etc/issue)" ]; then
        echo 'Only for Redhat or CentOS'
        exit
fi


yum remove -y dhclient dhcp-*

yum update -y
yum install -y telnet wget rsync vim-enhanced

#yum install -y openssh-clients

rpm -Uvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-2.noarch.rpm

cat >> /etc/security/limits.conf <<EOF

* soft nofile 4096
* hard nofile 4096
EOF


cat >> /etc/sysctl.conf <<EOF

net.ipv4.ip_local_port_range = 1024 65500
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_tw_recycle = 1
net.ipv4.tcp_fin_timeout = 60
net.ipv4.tcp_keepalive_time = 1800
net.core.netdev_max_backlog=3000
net.ipv4.tcp_max_syn_backlog = 8192
net.ipv4.tcp_max_tw_buckets = 4096
EOF

cat >> /etc/bashrc <<EOF

export HISTTIMEFORMAT="%Y-%m-%d-%H:%M:%S "
EOF
