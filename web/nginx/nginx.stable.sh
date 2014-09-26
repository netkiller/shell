#!/bin/bash
#cat > /etc/yum.repos.d/nginx.repo <<EOF
#[nginx]
#name=nginx repo
#baseurl=http://nginx.org/packages/centos/6/x86_64/
#gpgcheck=0
#enabled=1
#EOF
rpm -ivh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm

#yum search nginx

yum install -y nginx
chkconfig nginx on
service nginx start

cp /etc/nginx/nginx.conf{,.original}

vim /etc/nginx/nginx.conf <<VIM > /dev/null 2>&1
:%s/worker_processes  1;/worker_processes  8;/
:%s/worker_connections  1024;/worker_connections  4096;/
:%s/#gzip/server_tokens off;\r    gzip/
:%s/#gzip/gzip/
:wq
VIM
