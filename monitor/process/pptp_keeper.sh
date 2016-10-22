#!/bin/sh
#==========================================
# PPTP Keeper
# Author: netkiller<netkiller@msn.com>
# Home: http://netkiller.github.io
#==========================================
LOGFILE=/var/log/ppp/$(basename $0 .sh).log
PATTERN="pppd"
NAME="cfd"
RECOVERY="/usr/sbin/pppd call ${NAME}"

while true
do
    TIMEPOINT=$(date -d "today" +"%Y-%m-%d_%H:%M:%S")
    PROC=$(pgrep -o -f ${PATTERN})
    #echo ${PROC}
    if [ -z "${PROC}" ]; then
	${RECOVERY} 
	echo "[${TIMEPOINT}] The system can not find the process" >> $LOGFILE
	echo "[${TIMEPOINT}] ${PATTERN} ${RECOVERY}" >> $LOGFILE
    fi

    LINK=$(ip link | grep ppp0 | grep UP)
    if [ -z "${LINK}" ]; then
	pkill pppd
	${RECOVERY} 
	echo "[${TIMEPOINT}] The adapter ppp0 isn't exist!" >> $LOGFILE
	echo "[${TIMEPOINT}] ${PATTERN} ${RECOVERY}" >> $LOGFILE
    fi

sleep 5
done &

