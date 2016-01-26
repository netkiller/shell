#!/bin/bash
##################################################
# Website http://www.netkiller.cn
# Author netkiller<netkiller@msn.com>
##################################################
PROG=$(basename $0)
LOGFILE=/var/tmp/$PROG.log
PIDFILE=/var/tmp/$PROG.pid
RRDDATA=/var/tmp/queue.rrd
PNGFILE=queue.png
QUEUE=example
##################################################

function create(){
	rrdtool create $RRDDATA \
        --start 1023654125 \
        --step 300 \
        DS:mem:GAUGE:600:0:671744 \
        RRA:AVERAGE:0.5:12:24 \
        RRA:AVERAGE:0.5:288:31
			
}

function collector(){
	queue=$(rabbitmqctl list_queues | grep $QUEUE | awk -F' ' '{print $2}')
	#echo "Current Queue is $queue"
	rrdtool update $RRDDATA N:${queue}
}
		

function generate(){		
	
	rrdtool graph $PNGFILE \
	--title="$QUEUE Usage" \
	--vertical-label="Burndown" \
	--start=0 \
	--end=start+1day \
	--color=BACK#CCCCCC \
	--color=CANVAS#CCFFFF \
	--color=SHADEB#9999CC \
	--height=125 \
	--upper-limit=656 \
	--lower-limit=0 \
	--rigid \
	--base=1024 \
	DEF:tot_mem=$RRDDATA:mem:AVERAGE \
	CDEF:tot_mem_cor=tot_mem,0,671744,LIMIT,UN,0,tot_mem,IF,1024,/ \
	CDEF:machine_mem=tot_mem,656,+,tot_mem,- \
	HRULE:656#000000:"Maximum Available Queue" \
	AREA:machine_mem#CCFFFF:"Burndown Unused" \
	AREA:tot_mem_cor#6699CC:"Total Burndown"
}
function daemon(){
	
	for (( ; ; )) do
		collector
		generate
		sleep 5
	done &
	echo $! > $PIDFILE
}	
function start(){
	if [ ! -f $RRDDATA ]; then
		create
	fi
	daemon
}
function stop(){
	[ -f $PIDFILE ] && kill `cat $PIDFILE` && rm -rf $PIDFILE
}
function status(){
  	ps ax | grep $PROG | grep -v grep | grep -v status
}
function usage(){
        echo $"Usage: $0 {start|stop}"
        echo $"
Options
 -v, --verbose               increase verbosity
 -q, --quiet                 suppress non-error messages
 -h, --help                  show this help (-h works with no other options)
"
}

case "$1" in
    create)
        create
        ;;
    start)
	start
	;;
    stop)
	stop
	;;
    status)
        status
        ;;
    -d)
        daemon
        ;;
    "--help")
        usage
        ;;
    *)
        usage
        RETVAL=2
        ;;
esac

exit $RETVAL
