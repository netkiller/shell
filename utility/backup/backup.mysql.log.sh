#!/bin/bash
USER=backup
PASS=SaJePoM6BAPOmOFOd7Xo3e1A52vEPE
LOGDIR=/backup/dblog
DATADIR=/var/lib/mysql
LOG=mysql.log
LOG_ERROR=mysql_error.log
LOG_SLOW_QUERIES=slow.log
SOCKET="/var/lib/mysql/mysql.sock"
MYSQLADMIN=/usr/bin/mysqladmin -u${USER} -p${PASS} --socket=${SOCKET}
#Number of copies
COPIES=365
SHARDING=$(date -d "yesterday" +"%Y-%m-%d.%H:%M:%S")

mkdir -p ${LOGDIR}/${SHARDING}

while read logfile age
do
	if [ -f ${DATADIR}/$logfile ]; then
		mv ${DATADIR}/$logfile ${LOGDIR}/${SHARDING}
	fi
done << EOF
${LOG}
${LOG_ERROR}
${LOG_SLOW_QUERIES}
EOF

if test -x /usr/bin/mysqladmin && \
   ${MYSQLADMIN} ping &>/dev/null
then
   ${MYSQLADMIN} flush-logs
fi

ls ${LOGDIR}/${SHARDING}/*.log >/dev/null 2>&1
if [ $? = 0 ]; then
	gzip ${LOGDIR}/${SHARDING}/*.log
fi

find $LOGDIR -type f -ctime +$COPIES -delete
