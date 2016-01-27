#!/bin/sh
timeout=$(grep -r "Connection timed out" /var/log/maillog | wc -l)
unreachable=$(grep "Network is unreachable" /var/log/maillog | wc -l)
status550=$(grep " 550 " /var/log/maillog | wc -l)
refused=$(grep "Connection refused" /var/log/maillog | wc -l)

printf "Connection timed out %s\n" $timeout
printf "Network is unreachable %s\n" $unreachable
printf "Connection frequency limited %s\n" $status550
printf "Connection refused %s\n" $refused
