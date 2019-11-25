#!/bin/bash 

cd /usr/local/src/

dnf install -y pcre-devel zlib-devel

wget https://fastdfs.googlecode.com/files/fastdfs-nginx-module_v1.15.tar.gz
tar zxf fastdfs-nginx-module_v1.15.tar.gz 

wget http://nginx.org/download/nginx-1.7.9.tar.gz
tar zxf nginx-1.7.9.tar.gz
cd nginx-1.7.9
./configure --prefix=/srv/nginx-1.7.9 \
--user=www --group=www \
--add-module=../fastdfs-nginx-module/src

make -j4  && make install

cp /srv/nginx-1.7.9/conf/nginx.conf{,.original}

vim /srv/nginx-1.7.9/conf/nginx.conf <<VIM > /dev/null 2>&1
:%s/worker_processes  1;/worker_processes  8;/
:%s/worker_connections  1024;/worker_connections  4096;/
:%s/#gzip/server_tokens off;\r    gzip/
:%s/#gzip/gzip/
:wq
VIM


cp /usr/local/src/fastdfs-nginx-module/src/mod_fastdfs.conf /etc/fdfs/
cp /etc/fdfs/mod_fastdfs.conf{,.original}

vim /etc/fdfs/mod_fastdfs.conf <<VIM > /dev/null 2>&1
:wq
VIM

#sed -i 's:store_path0=/home/yuqing/fastdfs:store_path0=/www/fastdfs:g' /etc/fdfs/mod_fastdfs.conf