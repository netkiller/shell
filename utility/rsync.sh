#!/bin/bash
ntpdate 172.16.1.10

pid=$(pgrep rsync)

if [ -z "$pid" ]; then

rsync -auzP --delete -e ssh  --exclude=zoshow/images --exclude=zoshow/product --exclude=zoshow/templates/caches --exclude=zoshow/admin root@172.16.2.10:/www/zoshow /www

fi

