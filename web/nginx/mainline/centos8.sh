#!/bin/bash 

cat > /etc/yum.repos.d/nginx.repo <<'EOF'
[nginx-stable]
name=nginx stable repo
baseurl=http://nginx.org/packages/centos/$releasever/$basearch/
gpgcheck=1
enabled=1
gpgkey=https://nginx.org/keys/nginx_signing.key
module_hotfixes=true

[nginx-mainline]
name=nginx mainline repo
baseurl=http://nginx.org/packages/mainline/centos/$releasever/$basearch/
gpgcheck=1
enabled=0
gpgkey=https://nginx.org/keys/nginx_signing.key
module_hotfixes=true
EOF

sudo yum-config-manager --enable nginx-mainline
sudo dnf install -y nginx


cp /etc/nginx/nginx.conf{,.original}

vim /etc/nginx/nginx.conf <<VIM > /dev/null 2>&1
:%s/worker_connections  1024;/worker_connections  4096;/
:wq
VIM

cat << 'EOF' >>  /etc/nginx/conf.d/security.conf
server_tokens off;
gzip on;
gzip_vary on;
gzip_proxied any;
gzip_types text/plain text/css text/javascript application/javascript application/xml application/xml+rss application/json;
client_max_body_size 100m;
EOF

cat << 'EOF' >>  /etc/nginx/conf.d/expires.conf
	location ~ .*\.(htm|html)$
	{
		expires 5m;
	}
	location ~ .*\.(gif|jpg|jpeg|png|bmp|swf|ico)$
	{
		expires 1h;
	}	
	location ~ .*\.(js|css)$
	{
		expires 1h;
	}
	location ~ .*\.(rar|zip|txt|doc|ppt|pdf|xls|mp3|wma|flv|mid)$
	{
		expires 1d;
	}
EOF

systemctl enable nginx
systemctl start nginx