#!/bin/bash

#dnf search nginx

dnf install -y nginx

cp /etc/nginx/nginx.conf{,.original}

vim /etc/nginx/nginx.conf <<VIM > /dev/null 2>&1
:%s/worker_connections 1024;/worker_connections 4096;/
:wq
VIM

sed -i '9iworker_rlimit_nofile 65530;' /etc/nginx/nginx.conf

sed -i "33 i \ \ \ \ gzip on;" /etc/nginx/nginx.conf
sed -i "34 i \ \ \ \ gzip_types text/plain text/css application/json application/x-javascript application/xml;" /etc/nginx/nginx.conf
sed -i "35 i \ \ \ \ server_tokens off;" /etc/nginx/nginx.conf

systemctl enable nginx
systemctl start nginx
