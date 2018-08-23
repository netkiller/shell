
# MySQL 8.0

	curl -s https://raw.githubusercontent.com/oscm/shell/master/database/mysql/8.0/mysql80-community-release.sh | bash

## Change password

    [root@netkiller ~]# grep "A temporary password" /var/log/mysqld.log
    2018-04-03T02:24:16.935070Z 1 [Note] A temporary password is generated for root@localhost: kMA*d<e#Q3EC
    2018-04-20T03:36:31.935143Z 5 [Note] [MY-010454] [Server] A temporary password is generated for root@localhost: MqatK=hae5F#

    [root@netkiller ~]# mysqladmin -u root -p'MqatK=hae5F#' password
    mysqladmin: [Warning] Using a password on the command line interface can be insecure.
    New password:
    Confirm new password:
    Warning: Since password will be sent to server in plain text, use ssl connection to ensure password safety.
   
## Add user

### MySQL 8.0 创建用户使用 5.x 无法链接

    mysql> CREATE USER 'root'@'%' IDENTIFIED BY 'MQiEge1ikst7S_6tlXzBOmt_4b';
    Query OK, 0 rows affected (0.05 sec)

    mysql> GRANT ALL ON *.* TO 'root'@'%';
    Query OK, 0 rows affected (0.03 sec)
    
### 兼容 5.7 使用 mysql_native_password 
    
    mysql> CREATE USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY 'pMQiEge1ikst7S_6tlXzBOmt_4b';
    Query OK, 0 rows affected (0.08 sec)

    mysql> grant all on *.* to 'root'@'%';
    Query OK, 0 rows affected (0.08 sec)

