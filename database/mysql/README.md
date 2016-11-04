MySQL
========

Server
------
    curl -s https://raw.githubusercontent.com/oscm/shell/master/database/mysql/mysql.server.sh | bash
    
    2016-02-16T08:22:58.253030Z 1 [Note] A temporary password is generated for root@localhost: sd%%my.Ak7Ma

Change password
-----
    
    $ mysqladmin -u root -p'<old_password>' password <new_password>

Client
-----
	curl -s https://raw.githubusercontent.com/oscm/shell/master/database/mysql/mysql.client.sh | bash
	
Devel
-----
    curl -s https://raw.githubusercontent.com/oscm/shell/master/database/mysql/mysql.devel.sh | bash

DBA User
-----
    GRANT ALL ON *.* TO 'dba'@'192.168.%' IDENTIFIED BY 'chen';

Upgrade to MySQL 5.7.x from 5.6.x
-----
	curl -s https://raw.githubusercontent.com/oscm/shell/master/database/mysql/upgrade.sh | bash
	
- - -

MySQL Router
-----
	curl -s https://raw.githubusercontent.com/oscm/shell/master/database/mysql/mysql57-community-release-el7-7.sh | bash
	curl -s https://raw.githubusercontent.com/oscm/shell/master/database/mysql/mysql-router.sh | bash
