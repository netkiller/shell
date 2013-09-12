#!/bin/bash
NODE="172.16.0.1 172.16.0.2 172.16.0.3 172.16.0.4 172.16.0.5"

for host in $NODE
do
        echo -n "${host}: "
        ssh root@${host} "$1" # > /dev/null 2>&1
done
