#!/bin/bash

sudo apt-get install php5
cp /etc/php5/cli/php.ini{,.original}

#vim /etc/php5/cli/php.ini <<end > /dev/null 2>&1

#:wq
#end