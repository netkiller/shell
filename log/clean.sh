COPIES=7
find /var/log -type f -mtime +$COPIES -delete

find -type f -name *.gz -delete
find -type f -name *.log.* -delete
find -type f -name *.log-* -delete