cat <<-EOF> /etc/nginx/conf.d/gzip.conf
gzip on;
gzip_vary on;
gzip_proxied any;
gzip_min_length 1000;
gzip_types text/plain text/css application/javascript application/json application/xml application/octet-stream image/svg+xml;
EOF

# text/html 类型无需配置，否则会提示
# nginx: [warn] duplicate MIME type "text/html" in /etc/nginx/conf.d/default.conf