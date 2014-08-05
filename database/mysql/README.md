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
