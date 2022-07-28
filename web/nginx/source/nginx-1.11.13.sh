#!/bin/bash 

cd /usr/local/src/

dnf install -y pcre-devel zlib-devel

groupadd -r nginx
useradd -s /sbin/nologin -g nginx -r nginx

wget https://www.openssl.org/source/openssl-1.1.0e.tar.gz
tar zxvf openssl-1.1.0e.tar.gz
cd openssl-1.1.0e/
./config --prefix=/srv/openssl-1.1.0e
make depend
make -j8
make install

rm -f /srv/openssl
ln -s /srv/openssl-1.1.0e/ /srv/openssl

cd /usr/local/src/

wget http://nginx.org/download/nginx-1.11.13.tar.gz
tar zxvf nginx-1.11.13.tar.gz
cd nginx-1.11.13
./configure --prefix=/srv/nginx-1.11.13 \
--pid-path=/var/run/nginx.pid \
--lock-path=/var/run/nginx.lock \
--http-client-body-temp-path=/var/cache/nginx/client_temp \
--http-proxy-temp-path=/var/cache/nginx/proxy_temp \
--http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
--http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
--http-scgi-temp-path=/var/cache/nginx/scgi_temp \
--user=nginx \
--group=nginx \
--with-openssl=../openssl-1.1.0e \
--with-file-aio \
--with-threads \
--with-http_addition_module \
--with-http_auth_request_module \
--with-http_flv_module \
--with-http_gunzip_module \
--with-http_gzip_static_module \
--with-http_mp4_module \
--with-http_realip_module \
--with-http_secure_link_module \
--with-http_slice_module \
--with-http_ssl_module \
--with-http_stub_status_module \
--with-http_sub_module \
--with-http_v2_module \
--with-stream \
--with-stream_ssl_module \
--with-cc-opt='-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches -m64 -mtune=generic -fPIC' \
--with-ld-opt='-Wl,-z,relro -Wl,-z,now -pie'

make -j4  && make install

rm -f /srv/nginx
ln -s /srv/nginx-1.11.13 /srv/nginx

strip /srv/nginx-1.11.13/sbin/nginx

cp /srv/nginx-1.11.13/conf/nginx.conf{,.original}

vim /srv/nginx-1.11.13/conf/nginx.conf <<VIM > /dev/null 2>&1
:%s/worker_processes  1;/worker_processes  auto;/
:%s/worker_connections  1024;/worker_connections  4096;/
:%s/#gzip/server_tokens off;\r    gzip/
:%s/#gzip/gzip/
:wq
VIM

mkdir -p /var/cache/nginx/
chown nginx:nginx -R /var/cache/nginx/

wget -q https://raw.githubusercontent.com/netkiller/shell/master/web/nginx/source/nginx.service -O /usr/lib/systemd/system/nginx.service
systemctl enable nginx
systemctl start nginx