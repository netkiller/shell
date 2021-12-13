#!/bin/bash
###################################
# $Id$
# Author: netkiller@msn.com
# Home:	http://www.netkiller.cn
# Date: 2021-10-12
# Version: v2.0
###################################
# SELECT `user`, `host`, `password` FROM `mysql`.`user`;
# CREATE USER 'backup'@'localhost' IDENTIFIED BY 'SaJePoM6BAPOmOFOd7Xo3e1A52vEPE';
# GRANT SELECT, SHOW DATABASES, LOCK TABLES, EVENT ON *.* TO `backup`@`localhost`;
# FLUSH PRIVILEGES;
# SHOW GRANTS FOR 'backup'@'localhost';
###################################
BACKUP_HOST="localhost"
BACKUP_USER="backup"
BACKUP_PASS="SaJePoM6BAPOmOFOd7Xo3e1A52vEPE"
BACKUP_DBNAME="netkiller"
GIT=git@192.168.30.5:netkiller.cn/db.netkiller.cn.git
####################################
NAME=backup.mysql.struct
BASEDIR='/tmp'
WORKSPACE=~/.backup
PROG=$BASEDIR/bin/$(basename $0)
LOGFILE=/var/tmp/$NAME.log
PIDFILE=/var/tmp/$NAME.pid
MYSQLDUMP="/usr/bin/mysqldump"
MYSQLDUMP_OPTS="-h $BACKUP_HOST -u$BACKUP_USER -p$BACKUP_PASS --events --triggers --routines --skip-comments --skip-opt --log-error=$LOGFILE -d"
####################################
umask 0077
##############################################
#rotate=60
LOOP=30 
##############################################
function backup(){
	test ! -d "$WORKSPACE" && echo "Error: $WORKSPACE isn't a directory." && exit 0
	cd $WORKSPACE
	for dbname in $BACKUP_DBNAME
	do
		test ! -d "$WORKSPACE/$BACKUP_HOST" && mkdir -p "$WORKSPACE/$BACKUP_HOST"
		$MYSQLDUMP $MYSQLDUMP_OPTS $dbname | sed 's/AUTO_INCREMENT=[0-9]\+//' > $WORKSPACE/$BACKUP_HOST/$dbname.sql
	       #	> /dev/null 2>&1
	done
	TIMEPOINT=$(date +%Y-%m-%d.%H:%M:%S)
	git pull
	git add .
	git commit --quiet -m "$TIMEPOINT" > /dev/null
	git push > /dev/null 2>&1
}
function start(){
	if [ -f "$PIDFILE" ]; then
		echo $PIDFILE
		exit 2
	fi
	test ! -w $WORKSPACE && echo "Error: $WORKSPACE is un-writeable." && exit 0
	
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
	
	if [ ! -d $WORKSPACE ]; then
		git clone ${GIT} ${WORKSPACE}
	fi

}
case "$1" in
  backup)
  	backup
	;;	
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