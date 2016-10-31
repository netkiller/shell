#!/bin/sh
#==========================================
# Process Keeper
# Author: netkiller<netkiller@msn.com>
# Home: http://netkiller.github.io
#==========================================
LOGFILE=/var/log/$(basename $0 .sh).log
PATTERN="php-fpm"
RECOVERY="/etc/init.d/php-fpm restart"
#==========================================
while true
do
    TIMEPOINT=$(date -d "today" +"%Y-%m-%d_%H:%M:%S")
    PROC=$(pgrep -o -f ${PATTERN})
    #echo ${PROC}
    if [ -z "${PROC}" ]; then
		${RECOVERY} >> $LOGFILE
		echo "[${TIMEPOINT}] ${PATTERN} ${RECOVERY}" >> $LOGFILE
    #else
        #echo "[${TIMEPOINT}] ${PATTERN} ${PROC}" >> $LOGFILE
    fi
sleep 5
done &
