ss -ant | awk '{++stats[$1]} END {for(a in stats) print a, stats[a]}'

#ss -ant | awk 'BEGIN {stats["CLOSE-WAIT"]=0;stats["ESTAB"]=0;stats["FIN-WAIT-1"]=0;stats["FIN-WAIT-2"]=0;stats["LAST-ACK"]=0;stats["SYN-RECV"]=0;stats["SYN-SENT"]=0;stats["TIME-WAIT"]=0} {++stats[$1]} END {for(a in stats) print a, stats[a]}'
