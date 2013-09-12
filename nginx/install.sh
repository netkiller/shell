#!/bin/bash 
ARCH=$(uname -i)
SYSTEM=$(cat /etc/issue | awk -F' ' '{if(NR==1) print $1}')
VERSION=$(cat /etc/issue | awk -F'[ |.]' '{if(NR==1) print $3}')

cat > /etc/yum.repos.d/nginx.repo <<EOF
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/${VERSION}/${ARCH}/
gpgcheck=0
enabled=1
EOF

yum install -y nginx
chkconfig nginx on

cp /etc/nginx/nginx.conf{,.original}

vim /etc/nginx/nginx.conf <<VIM > /dev/null 2>&1
:%s/#gzip/server_tokens off;\r    gzip/
:%s/#gzip/gzip/
:wq
VIM

service nginx start
