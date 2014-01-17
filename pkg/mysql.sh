pkg_add -r mysql56-server
pkg_add -r mysql56-client

/usr/local/etc/rc.d/mysql-server onestart
/usr/local/bin/mysqladmin -u root password 'newpassword'

cat >> /etc/rc.conf <<EOF
mysql_enable="YES"
EOF
