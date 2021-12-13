#!/bin/bash
###################################
# $Id$
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
BACKUP_USER="backup"
BACKUP_PASS="chen"
BACKUP_DBNAME="test aabbcc"
BACKUP_DIR=~/backup
####################################
NAME=backup.mysql.struct
BASEDIR='/www'
PROG=$BASEDIR/bin/$(basename $0)
LOGFILE=/var/tmp/$NAME.log
PIDFILE=/var/tmp/$NAME.pid
MYSQLDUMP="/usr/bin/mysqldump"
MYSQLDUMP_OPTS="-h $BACKUP_HOST -u$BACKUP_USER -p$BACKUP_PASS --events --triggers --routines --skip-comments --log-error=$LOGFILE -d"
####################################
umask 0077
##############################################
#rotate=60
LOOP=30 
##############################################
function backup(){
	test ! -d "$BACKUP_DIR" && echo "Error: $BACKUP_DIR isn't a directory." && exit 0
	cd $BACKUP_DIR
	for dbname in $BACKUP_DBNAME
	do
		test ! -d "$BACKUP_DIR/$BACKUP_HOST" && mkdir -p "$BACKUP_DIR/$BACKUP_HOST"
		$MYSQLDUMP $MYSQLDUMP_OPTS $dbname > $BACKUP_DIR/$BACKUP_HOST/$dbname.sql > /dev/null 2>&1
	done
	TIMEPOINT=$(date -u +%Y-%m-%d.%H:%M:%S)
	git add .
	git commit --quiet -m "$TIMEPOINT" > /dev/null
}
function start(){
	if [ -f "$PIDFILE" ]; then
		echo $PIDFILE
		exit 2
	fi
	test ! -w $BACKUP_DIR && echo "Error: $BACKUP_DIR is un-writeable." && exit 0
	
	for (( ; ; ))
	do
		backup
		sleep $LOOP
	done &
	echo $! > $PIDFILE
}
function stop(){
  	[ -f $PIDFILE ] && kill `cat $PIDFILE` && rm -rf $PIDFILE
}
function init(){
	
	if [ ! -d $BACKUP_DIR ]; then
		mkdir -p "$BACKUP_DIR"
		cd $BACKUP_DIR
		git init
    fi
	backup
}
case "$1" in
  start)
  	start
	;;
  stop)
  	stop
	;;
  status)
  	ps ax | grep $(basename $0) | grep -v grep | grep -v status
	;;
  restart)
  	stop
	start
	;;
	init)
		init
		;;
	*)
		echo $"Usage: $0 {init|start|stop|status|restart}"
		exit 127
esac

exit $?
