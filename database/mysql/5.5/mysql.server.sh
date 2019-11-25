mkdir -p /srv/pkg/mysql
cd /srv/pkg/mysql

wget http://cdn.mysql.com/Downloads/MySQL-5.5/MySQL-server-5.5.28-1.el6.x86_64.rpm

rpm -e --nodeps mysql-libs
dnf localinstall MySQL-server-5.5.28-1.el6.x86_64.rpm