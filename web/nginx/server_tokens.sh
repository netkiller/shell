sed -i '/http {/a \
    server_tokens off;' /etc/nginx/nginx.conf