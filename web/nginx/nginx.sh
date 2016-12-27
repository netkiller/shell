#!/bin/bash

rpm -ivh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm

#yum search nginx

yum install -y nginx

cp /etc/nginx/nginx.conf{,.original}

vim /etc/nginx/nginx.conf <<VIM > /dev/null 2>&1
:%s/worker_processes  1;/worker_processes  8;/
:%s/worker_connections  1024;/worker_connections  4096;/
:%s/#gzip/server_tokens off;\r    gzip/
:%s:#gzip:gzip\r    gzip_types text/plain text/css application/json application/x-javascript application/xml;:
:wq
VIM

sed -i '4iworker_rlimit_nofile 65530;' /etc/nginx/nginx.conf

systemctl enable nginx
systemctl start nginx
