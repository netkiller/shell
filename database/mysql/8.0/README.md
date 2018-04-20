# MySQL 8.0

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

    mysql> CREATE USER 'root'@'%' IDENTIFIED BY 'MQiEge1ikst7S_6tlXzBOmt_4b';
    Query OK, 0 rows affected (0.05 sec)

    mysql> GRANT ALL ON *.* TO 'root'@'%';
    Query OK, 0 rows affected (0.03 sec)
