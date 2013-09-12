#!/bin/sh
while true
do
        date=$(date -d "today" +"%Y-%m-%d_%H:%M:%S")
        memconsum=$(netstat -ant | grep ":11211 " | wc -l)
        #echo ${memconsum}
        if [ ${memconsum} -gt 2000 ]
        then
                echo "memcache conneting number is ${memconsum}, restart at $date">>mem_restart.log
                /etc/init.d/memcached restart

        else
                echo "memconsum=${memconsum}">>mem_restart.log
        fi
sleep 60
done

