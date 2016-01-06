mkdir -p /srv/pkg/mysql
cd /srv/pkg/mysql

wget http://cdn.mysql.com/Downloads/MySQL-5.5/MySQL-devel-5.5.28-1.el6.x86_64.rpm
wget http://cdn.mysql.com/Downloads/MySQL-5.5/MySQL-shared-5.5.28-1.el6.x86_64.rpm
wget http://cdn.mysql.com/Downloads/MySQL-5.5/MySQL-shared-compat-5.5.28-1.el6.x86_64.rpm

rpm -e --nodeps mysql-libs
yum localinstall MySQL-devel-5.5.28-1.el6.x86_64.rpm MySQL-shared-5.5.28-1.el6.x86_64.rpm MySQL-shared-compat-5.5.28-1.el6.x86_64.rpm