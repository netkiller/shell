#!/bin/bash
###################################
# $Id: backup 379 2013-06-17 18:00:00Z netkiller $
# Author: netkiller@msn.com
# Home:	http://netkiller.github.io
###################################
BACKUP_DIR=/www/backup
###################################
BACKUP_HOST=""
BACKUP_USER=""
BACKUP_PASS=""
###################################
BACKUP_DBNAME="wechat"
#Number of copies
COPIES=100
####################################
PGDUMP="pg_dump"
TIMEPOINT=$(date -u +%Y-%m-%d.%H-%M-%S)
#PGDUMP_OPTS="-h $BACKUP_HOST -U $BACKUP_USER -W $BACKUP_PASS"
PGDUMP_OPTS="--compress=8"
####################################
test ! -w $BACKUP_DIR && echo "Error: $BACKUP_DIR is un-writeable." && exit 0

umask 0077

for dbname in $BACKUP_DBNAME
do
	test ! -d "$BACKUP_DIR/$dbname" && mkdir -p "$BACKUP_DIR/$dbname"

	$PGDUMP $PGDUMP_OPTS --file=${BACKUP_DIR}/${dbname}/${dbname}.${TIMEPOINT}.sql $dbname 
done
find $BACKUP_DIR -type f -mtime +$COPIES -delete