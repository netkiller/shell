mkdir -p /srv/pkg/mysql
cd /srv/pkg/mysql

wget http://cdn.mysql.com/Downloads/MySQL-5.5/MySQL-client-5.5.28-1.el6.x86_64.rpm &
wget http://cdn.mysql.com/Downloads/MySQL-5.5/MySQL-embedded-5.5.28-1.el6.x86_64.rpm &
wget http://cdn.mysql.com/Downloads/MySQL-5.5/MySQL-test-5.5.28-1.el6.x86_64.rpm &

rpm -e --nodeps mysql-libs
dnf localinstall MySQL-*

