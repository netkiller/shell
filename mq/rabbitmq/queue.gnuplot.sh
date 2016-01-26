#!/bin/bash
##################################################
# Website http://www.netkiller.cn
# Author netkiller<netkiller@msn.com>
##################################################
PROG=$(basename $0)
LOGFILE=/var/tmp/$PROG.log
PIDFILE=/var/tmp/$PROG.pid
GNUPLOTDATA=/var/tmp/queue.rrd
PNGFILE=/www/example.com/www.example.com/public/img/queue
QUEUE=example
##################################################

function collector(){
	datetime=$(date '+%H:%M:%S')
	queue=$(rabbitmqctl list_queues | grep $QUEUE | awk -F' ' '{print $2}')
	echo "$datetime $queue" >> $GNUPLOTDATA
}
		

function generate(){		

datetime=$(date '+%Y/%m/%d %H:%M:%S')
gnuplot << EOF
set terminal png truecolor size 1024,480
set output "$PNGFILE-day.png"
set autoscale
set xdata time
set timefmt "%H:%M"
set format x "%H:%M"
set style data lines
set xlabel "$datetime GMT+800"
set ylabel "Burndown"
set title "RabbitMQ Burndown - Day"
set grid
plot "$GNUPLOTDATA" using 1:2 title "Burndown"
EOF

hour=$(date '+%H')
gnuplot << EOF
set terminal png truecolor size 1024,480
set output "$PNGFILE-hour.png"
set autoscale
set xdata time
set timefmt "%H:%M"
set xrange ["$hour:00":"$hour:24"]
set format x "%H:%M"
set style data lines
set xlabel "$datetime GMT+800"
set ylabel "Burndown"
set title "RabbitMQ Burndown - Hour"
set grid
plot "$GNUPLOTDATA" using 1:2 title "Burndown"
EOF

minute=$(date '+%H:%M')
minute5=$(date --date='5 minutes ago' "+%H:%M")
gnuplot << EOF >> $LOGFILE.minute
set terminal png truecolor size 1024,480
set output "$PNGFILE-minute.png"
set autoscale
set xdata time
set timefmt "%H:%M:%S"
set xrange ["$minute5:00":"$minute:60"]
set format x "%H:%M:%S"
set style data lines
set xlabel "$datetime GMT+800"
set ylabel "Burndown"
set title "RabbitMQ Burndown - Minute"
set grid
plot "$GNUPLOTDATA" using 1:2 title "Burndown"
EOF
	
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
function clean(){
	rm -rf $GNUPLOTDATA
}
function usage(){
        echo $"Usage: $0 {start|stop|restart|status|clean}"
        echo $"
Options
 -v, --verbose               increase verbosity
 -q, --quiet                 suppress non-error messages
 -h, --help                  show this help (-h works with no other options)

 Website http://www.netkiller.cn
 Author netkiller<netkiller@msn.com>
"
}

case "$1" in
    start)
	start
	;;
    stop)
	stop
	;;
    restart)
	stop
	start
	;;
    status)
        status
        ;;
    -d)
        daemon
        ;;
    clean)
        clean
        ;;
    *)
        usage
        ;;
esac

RETVAL=$?

exit $RETVAL
