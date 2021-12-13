#!/bin/bash
###################################
# $Id: backup 379 2012-04-02 08:43:42Z netkiller $
# Author: netkiller@msn.com
# Home:	http://netkiller.github.com
###################################
# SELECT `user`, `host`, `password` FROM `mysql`.`user`;
# CREATE USER 'backup'@'localhost' IDENTIFIED BY 'SaJePoM6BAPOmOFOd7Xo3e1A52vEPE';
# GRANT SELECT, LOCK TABLES  ON *.* TO 'backup'@'localhost';
# FLUSH PRIVILEGES;
# SHOW GRANTS FOR 'backup'@'localhost';
###################################
BACKUP_HOST="localhost"
BACKUP_USER="root"
BACKUP_PASS="PA3nScWWdqC3Ww4KPu"
BACKUP_DIR=/opt/backup
BACKUP_DBNAME="dbname"
TIMEPOINT=$(date -u +%Y-%m-%d)
#TIMEPOINT=$(date -u +%Y-%m-%d.%H:%M:%S)
RECIPIENT=netkiller@msn.com
#Number of copies
COPIES=30
####################################
MYSQLDUMP="/usr/bin/mysqldump"
MYSQLDUMP_OPTS="-h $BACKUP_HOST -u$BACKUP_USER -p$BACKUP_PASS --compress --events --triggers --routines --single-transaction --set-gtid-purged=OFF"
# --skip-lock-tables --all-databases
####################################
umask 0077
test ! -d "$BACKUP_DIR" && mkdir -p "$BACKUP_DIR"
test ! -w $BACKUP_DIR && echo "Error: $BACKUP_DIR is un-writeable." && exit 0

for dbname in $BACKUP_DBNAME
do
	test ! -d "$BACKUP_DIR/$dbname" && mkdir -p "$BACKUP_DIR/$dbname"
	LOGFILE=$BACKUP_DIR/$dbname/error.log
	$MYSQLDUMP $MYSQLDUMP_OPTS --log-error=$LOGFILE $dbname | gpg -r ${RECIPIENT} -e -o $BACKUP_DIR/$dbname/$dbname.$TIMEPOINT.sql.gpg
done
find $BACKUP_DIR -type f -mtime +$COPIES -delete
