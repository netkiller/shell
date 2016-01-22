#!/bin/bash
for line in $(cat domain.lst);
do
	directory="/www/$line/www.$line"
	mkdir -p $directory;
	[ $? -eq 0 ] || exit 10
	echo "$directory is ok "
done

while read domain
do

cat > /etc/nginx/conf.d/$domain.conf <<EOF
server {
    listen       80;
    server_name  *.$domain;

    access_log /var/log/nginx/$domain.access.log;
	error_log /var/log/nginx/$domain.error.log;

    location / {
        root   /www/$domain/www.$domain;
        index  index.html;
    }

}
EOF

echo "/etc/nginx/conf.d/$domain.conf is ok"

done < domain.lst