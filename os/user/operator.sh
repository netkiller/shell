usermod -s /bin/bash -aG wheel operator
#-d /home/operator -g wheel
#cp -r /etc/skel /home/operator
#chown operator:wheel -R /home/operator
#usermod -aG wheel operator

PASSWORD=$(cat /dev/urandom | tr -dc [:alnum:] | head -c 32)

echo operator:${PASSWORD} | chpasswd
echo "operator password: ${PASSWORD}"