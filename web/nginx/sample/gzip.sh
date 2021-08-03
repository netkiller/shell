cat <<-EOF> /etc/nginx/conf.d/gzip.conf
gzip on;
gzip_vary on;
gzip_proxied any;
gzip_min_length 1000;
gzip_types text/html text/plain text/css application/javascript application/json application/xml application/octet-stream;
EOF