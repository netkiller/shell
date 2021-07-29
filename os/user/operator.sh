usermod -d /home/operator -s /bin/bash -g wheel operator
cp -r /etc/skel /home/operator
chown operator:wheel -R /home/operator

PASSWORD=$(cat /dev/urandom | tr -dc [:alnum:] | head -c 32)

echo "www password: ${PASSWORD}"
echo www:${PASSWORD} | chpasswd