MySQL
========

Server
------
    curl -s https://raw.githubusercontent.com/oscm/shell/master/database/mysql/mysql.server.sh | bash

Devel
-----
    curl -s https://raw.githubusercontent.com/oscm/shell/master/database/mysql/mysql.devel.sh | bash

DBA User
-----
    GRANT ALL ON *.* TO 'dba'@'192.168.%' IDENTIFIED BY 'chen';

Upgrade to MySQL 5.7.x from 5.6.x
-----
	curl -s https://raw.githubusercontent.com/oscm/shell/master/database/mysql/upgrade.sh | bash