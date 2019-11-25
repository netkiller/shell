dnf install -y haproxy

cp /etc/haproxy/haproxy.cfg{,.original}

systemctl enable haproxy
systemctl start haproxy