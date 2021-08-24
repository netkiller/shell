#groupadd -g 80 www
#adduser -o --uid 80 --gid 80 -c "Web Application" www
#adduser -o --home /www --uid 80 --gid 80 -c "Web Application" www
#chown www:www -R /www
#usermod -aG wheel www

groupadd -g 80 www
adduser -o --uid 80 --gid 80 -G wheel -c "Web Application" www

PASSWORD=$(cat /dev/urandom | tr -dc [:alnum:] | head -c 32)
echo "www password: ${PASSWORD}"
echo www:${PASSWORD} | chpasswd