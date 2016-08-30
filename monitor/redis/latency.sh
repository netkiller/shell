#!/bin/bash
########################################
# Redis latency monitor
########################################
# Home: http://www.netkiller.cn
# Author: neo<netkiller@msn.com
########################################

redis-cli --latency -h 192.168.2.1 &
sleep 0.5
kill $!
