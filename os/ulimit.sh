cat > /etc/security/limits.d/20-nofile.conf <<EOF

www soft nofile 65535
www hard nofile 65535

nginx soft nofile 65535
nginx hard nofile 65535

mysql soft nofile 65535
mysql hard nofile 65535

redis soft nofile 65535
redis hard nofile 65535

rabbitmq soft nofile 40960
rabbitmq hard nofile 40960

EOF
