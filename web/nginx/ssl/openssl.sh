
mkdir /etc/nginx/ssl
cd /etc/nginx/ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/www.netkiller.cn.key -out /etc/nginx/ssl/www.netkiller.cn.crt