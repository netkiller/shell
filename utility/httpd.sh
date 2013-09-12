#!/bin/bash

############################
logfile=/www/logs/httpd.log
APACHE_HOME=/usr/local/httpd
MIN_MEMORY_LIMIT=256
httpd_script_restart="$APACHE_HOME/bin/apachectl restart"
############################

function logs(){
        local logfile="$logfile.$(date -d "today" +"%Y-%m-%d")"
        local timepoint=$(date -d "today" +"%Y-%m-%d_%H:%M:%S")
        local status=$1
        local message=$2
        echo "[$timepoint] [${status}] ${message}" >> $logfile
}

#logs 'OK' 'This is test msg!!!'

function httpd_monitor_mem(){
        #memory_size=$(free -m | head -n 2 | tail -n 1 | awk '{print $(4)}')
        #memory_status=$(free -m | head -n 2 | tail -n 1 | awk '{print "Mem total(M): "$2", used: "$3", free: "$4}')

        memory_size=$(free -m | head -n 3 | tail -n 1 | awk '{print $(4)}')
        memory_status=$(free -m | head -n 2 | tail -n 1 | awk '{print "Mem total(M): "$2", used: "$3", free: "$4}')
        memory_status="${memory_status} $(free -m | head -n 3 | tail -n 1 | awk '{print "buffer: "$3" cache: "$4}')"
        memory_status="${memory_status} $(free -m | head -n 4 | tail -n 1 | sed 's/\s./ /g')"

        if [ ${memory_size} -lt $MIN_MEMORY_LIMIT ]; then
                $httpd_script_restart
                logs 'RESTART' "${memory_status}"
        else
                logs 'OK' "${memory_status}"
        fi
}

function httpd_monitor_port(){
	#curl --silent --max-time 10 --output /dev/null --write-out %{http_code} http://server:port/filename
        #http_status=$(curl -o /dev/null -s -w %{http_code} -x 127.0.0.1:80 www.example.com/index.php)
        http_status=$(curl -o /dev/null -s -w %{http_code} localhost/index.html)
        if [ ${http_status} == 200 ]; then
		logs 'OK' "${http_status}"
        else
		$httpd_script_restart >/dev/null 2>&1
		logs 'RESTART' "${http_status}"
        fi
}
##################################
while true
do
        httpd_monitor_mem
        sleep 5
done

#while true
#do
#        httpd_monitor_port
#	sleep 5
#done

##################################
