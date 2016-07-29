#!/bin/bash
###################################
# $Id: backup 379 2012-04-02 08:43:42Z netkiller $
# Author: netkiller@msn.com
# Home:	http://www.netkiller.cn
###################################
#Number of copies
COPIES=30
###################################
BACKUP_HOST="localhost"
BACKUP_USER="admin"
BACKUP_PASS=""
BACKUP_DBNAME="dbname"
BACKUP_DIR=/opt/backup
####################################
DUMP="/usr/bin/mongodump"
LOGFILE=/var/tmp/backup.mongodb.log
#TIMEPOINT=$(date -u +%Y-%m-%d)
TIMEPOINT=$(date -u +%Y-%m-%d.%H:%M:%S)
DUMP_OPTS="-h $BACKUP_HOST -u$BACKUP_USER -p$BACKUP_PASS"
####################################
umask 0077
test ! -d "$BACKUP_DIR" && mkdir -p "$BACKUP_DIR"
test ! -w $BACKUP_DIR && echo "Error: $BACKUP_DIR is un-writeable." && exit 0

for dbname in $BACKUP_DBNAME
do
	test ! -d "$BACKUP_DIR/$dbname" && mkdir -p "$BACKUP_DIR/$dbname"

	$DUMP $DUMP_OPTS -d $dbname -o $BACKUP_DIR/$TIMEPOINT >> $LOGFILE
done

find $BACKUP_DIR -type f -mtime +$COPIES -delete
