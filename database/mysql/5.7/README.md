MySQL
========

    curl -s https://raw.githubusercontent.com/oscm/shell/master/database/mysql/5.7/mysql57-community-release-el7-11.sh | bash

Server
------
    curl -s https://raw.githubusercontent.com/oscm/shell/master/database/mysql/5.7/mysql.server.sh | bash
    
    2016-02-16T08:22:58.253030Z 1 [Note] A temporary password is generated for root@localhost: sd%%my.Ak7Ma

Change password
-----
    
    $ mysqladmin -u root -p'<old_password>' password <new_password>

Client
-----
	curl -s https://raw.githubusercontent.com/oscm/shell/master/database/mysql/5.7/mysql.client.sh | bash
	
Devel
-----
    curl -s https://raw.githubusercontent.com/oscm/shell/master/database/mysql/5.7/mysql.devel.sh | bash

DBA User
-----
    GRANT ALL ON *.* TO 'dba'@'192.168.%' IDENTIFIED BY 'chen';

Java connector
-----

curl -s https://raw.githubusercontent.com/oscm/shell/master/database/mysql/5.7/mysql-connector-java.sh | bash
	
- - -
