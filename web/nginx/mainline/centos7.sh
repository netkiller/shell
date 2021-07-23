#!/bin/bash 
ARCH=$(uname -i)
SYSTEM=$(cat /etc/centos-release | awk -F' ' '{if(NR==1) print $1}')
VERSION=$(cat /etc/centos-release | awk -F'[ |.]' '{if(NR==1) print $3}')

cat > /etc/yum.repos.d/nginx.repo <<'EOF'
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/mainline/centos/7/$basearch/
gpgcheck=0
enabled=1
EOF

dnf install -y nginx

cp /etc/nginx/nginx.conf{,.original}

vim /etc/nginx/nginx.conf <<VIM > /dev/null 2>&1
:%s/worker_processes  1;/worker_processes  8;/
:%s/worker_connections  1024;/worker_connections  4096;/
:%s/#gzip/server_tokens off;\r    gzip/
:wq
VIM

systemctl enable nginx
systemctl start nginx
