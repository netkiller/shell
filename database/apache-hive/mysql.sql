CREATE DATABASE hive;
CREATE USER 'hive'@'localhost' IDENTIFIED BY 'hive';
GRANT ALL ON hive.* TO 'hive'@'localhost' IDENTIFIED BY 'hive';
GRANT ALL ON hive.* TO 'hive'@'%' IDENTIFIED BY 'hive';
FLUSH PRIVILEGES;
quit;
