#!/bin/bash

if [ ! -f /usr/bin/vim ] ; then
	alias vim='vi'
fi

if [ -z "$( egrep "CentOS|Redhat" /etc/issue)" ]; then
	echo 'Only for Redhat or CentOS'
	exit
fi

echo -ne "
search xiu.com
nameserver 172.16.3.51
nameserver 172.16.3.52
nameserver 208.67.222.222
nameserver 202.67.220.220
nameserver 8.8.8.8
nameserver 4.4.4.4
" > /etc/resolv.conf

echo -ne "

* soft nofile 65536
* hard nofile 65536
" >>/etc/security/limits.conf

cat >> /etc/sysctl.conf <<EOF

net.ipv4.ip_local_port_range = 1024 65500
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_tw_recycle = 1
net.ipv4.tcp_fin_timeout = 60
net.ipv4.tcp_keepalive_time = 1200
net.ipv4.tcp_max_syn_backlog = 8192
net.ipv4.tcp_max_tw_buckets = 4096
EOF

yum update -y
rpm --import http://apt.sw.be/RPM-GPG-KEY.dag.txt
rpm -K http://packages.sw.be/rpmforge-release/rpmforge-release-0.5.2-2.el6.rf.x86_64.rpm
rpm -i http://packages.sw.be/rpmforge-release/rpmforge-release-0.5.2-2.el6.rf.x86_64.rpm
