#!/bin/bash
##################################################
# Website http://www.netkiller.cn
# Author netkiller<netkiller@msn.com>
# netkiller https://github.com/netkiller/shell
##################################################
# You have to clean data  at midnight
# crontab -e
# 05 00 * * * /www/queue.gnuplot.sh clean
##################################################
QUEUES="example|other"
##################################################
PROG=$(basename $0 .sh)
LOGFILE=/var/tmp/$PROG.log
PIDFILE=/var/tmp/$PROG.pid
GNUPLOTDATA=/var/tmp/$PROG.data
PNGFILE=/www/example.com/www.example.com/public/img/queue
##################################################

function collector(){
	datetime=$(date '+%H:%M:%S')
	list_queues=$(rabbitmqctl list_queues | grep -v "\." | egrep "$QUEUES" | awk -F' ' '{print $2}' | tr '\n' ' ')
	echo "$datetime $list_queues" >> $GNUPLOTDATA
}

function generate(){		

	captions=()
	queues=($(echo $QUEUES | tr '|' ' '))
	
	for key in ${!queues[@]}; do
		column=$((key+2))
		captions+=("\"$GNUPLOTDATA\" using 1:${column} title \"${queues[${key}]}\"")
	done

	plot=$(IFS=,; echo "${captions[*]}")

datetime=$(date '+%Y-%m-%d %H:%M:%S')
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
plot $plot
EOF

hour=$(date '+%H')
gnuplot << EOF
set terminal png truecolor size 1024,480
set output "$PNGFILE-hour.png"
set autoscale
set xdata time
set timefmt "%H:%M"
set xrange ["$hour:00":"$hour:60"]
set format x "%H:%M"
set style data lines
set xlabel "$datetime GMT+800"
set ylabel "Burndown"
set title "RabbitMQ Burndown - Hour"
set grid
plot $plot
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
plot $plot
EOF
	
}
function daemon(){
	
	for (( ; ; )) do
		collector
		generate
		sleep 60
	done &
	echo $! > $PIDFILE
}	
function start(){
	if [ ! -f $GNUPLOTDATA ]; then
		collector
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
function create(){
	generate
}
function usage(){
        echo $"Usage: $0 {start|stop|restart|status|clean|create}"
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
	create)
		create
		;;
    *)
        usage
        ;;
esac

RETVAL=$?

exit $RETVAL
