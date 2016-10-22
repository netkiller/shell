#!/bin/sh
#==========================================
# PPTP Keeper
# Author: netkiller<netkiller@msn.com>
# Home: http://netkiller.github.io
#==========================================
NAME="vpn0"
IPADDR=
PATTERN="pppd"
RECOVERY="/usr/sbin/pppd call ${NAME}"
LOGFILE=/var/log/ppp/$(basename $0 .sh).log
PIDFILE=/var/run/$NAME.pid
PROG=$(basename $0)
#==========================================
#echo $$
function daemon(){
	
	while true
	do
		sleep 5
	
		TIMEPOINT=$(date -d "today" +"%Y-%m-%d_%H:%M:%S")
		PROC=$(pgrep -o -f ${PATTERN})
		#echo ${PROC}
		if [ -z "${PROC}" ]; then
			${RECOVERY} 
			echo "[${TIMEPOINT}] [${PATTERN}] The system can not find the process ${RECOVERY}" >> $LOGFILE
			continue
		fi

		LINK=$(ip link | grep ppp0 | grep UP)
		if [ -z "${LINK}" ]; then
			pkill ${PATTERN}
			${RECOVERY} 
			echo "[${TIMEPOINT}] [${PATTERN}] The adapter ppp0 isn't exist! ${RECOVERY}" >> $LOGFILE
			continue
		fi
		
		if [ -z "${IPADDR}" ]; then
			continue
		else
		
			PORT=$(echo -e "\r\n"|telnet ${IPADDR} 80 2> /dev/null | grep Connected)			
			if [ -z "${LINK}" ]; then
				echo "[${TIMEPOINT}] [${PATTERN}] The port of ${IPADDR} isn't exist!" >> $LOGFILE
				continue
			fi
		
		fi

	done &	

	echo $! > $PIDFILE
}
function start(){
	if [ -f "$PIDFILE" ]; then
		echo $PIDFILE
		exit 2
	fi
	
	TIMEPOINT=$(date -d "today" +"%Y-%m-%d_%H:%M:%S")
	echo "[${TIMEPOINT}] ----- begin -----" >> $LOGFILE
	daemon

}
function stop(){
	pkill ${PATTERN}
	[ -f $PIDFILE ] && kill `cat $PIDFILE` && rm -rf $PIDFILE
	TIMEPOINT=$(date -d "today" +"%Y-%m-%d_%H:%M:%S")
	echo "[${TIMEPOINT}] ----- end -----" >> $LOGFILE
}

case "$1" in
	start)
		start
		;;
	stop)
		stop
		;;
	status)
		ps ax | egrep  "(pppd|pptp|${PROG})" | grep -v grep | grep -v status
		;;
	restart)
		stop
		start
		;;
	log)
		tail -f ${LOGFILE}
		;;
	*)
		echo $"Usage: $0 {start|stop|status|restart|log}"
		exit 2
esac

exit $?