#!/bin/sh
#==========================================
# PPTP Keeper
# Author: netkiller<netkiller@msn.com>
# Home: http://netkiller.github.io
#==========================================
NAME="vpn0"
DESTINATION="127.0.0.1 80"
PATTERN="pppd"
RECOVERY="/usr/sbin/pppd call ${NAME}"
LOGFILE=/var/log/ppp/$(basename $0 .sh).log
PIDFILE=/var/run/$NAME.pid
PROG=$(basename $0)
#==========================================
TIMEOUT=30
read ipaddr port <<< $(echo $DESTINATION)

function daemon(){
	
	while true
	do
		sleep 10
	
		TIMEPOINT=$(date -d "today" +"%Y-%m-%d_%H:%M:%S")	
		
		PROC=$(pgrep -o -f ${PATTERN})
		if [ -z "${PROC}" ]; then
			${RECOVERY} 
			echo "[${TIMEPOINT}] [${NAME}] The system can not find the process ${RECOVERY}" >> $LOGFILE
			continue
		fi
		
		LINK=$(ip link | grep ppp0 | grep UP)
		if [ -z "${LINK}" ]; then
			pkill ${PATTERN}
			${RECOVERY} 
			echo "[${TIMEPOINT}] [${NAME}] The adapter ppp0 isn't exist! ${RECOVERY}" >> $LOGFILE
			continue
		fi		
		
		if [ -n "${ipaddr}" ]; then
			#CONNECTED=$(echo -e "\r\n"|telnet ${ipaddr} ${port} 2> /dev/null | grep Connected)
			#CONNECTED=$(echo -e "\r\n"|nc -v -w ${TIMEOUT} ${ipaddr} ${port} 2>&1 | grep "Connection timed out")			
			CONNECTED=$(echo -e "\r\n"|nc -v -w ${TIMEOUT} ${ipaddr} ${port} 2>&1 | grep Connected)
			if [ -z "${CONNECTED}" ]; then
				pkill ${PATTERN}
				${RECOVERY}
				echo "[${TIMEPOINT}] [${NAME}] ${ipaddr} ${port} Connection timed out!" >> $LOGFILE
				continue
			#else 
				#echo "[${TIMEPOINT}] [${NAME}] ${CONNECTED}" >> $LOGFILE
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