#!/bin/bash

yum install -y nrpe nagios-plugins
vi /etc/nagios/nrpe.cfg <<VIM > /dev/null 2>&1
:%s/allowed_hosts=127.0.0.1/allowed_hosts=172.16.1.2/
:wq
VIM

cat >> /etc/nagios/nrpe.cfg <<EOF

#command[check_http]=/usr/lib64/nagios/plugins/check_http -I 127.0.0.1 -p 80 -u http://www.example.com/index.html
command[check_swap]=/usr/lib64/nagios/plugins/check_swap -w 20% -c 10%
command[check_all_disks]=/usr/lib64/nagios/plugins/check_disk -w 20% -c 10% -e
EOF

chkconfig nrpe on
service nrpe start

cat >> cat /etc/services <<EOD

nrpe      5666/tcp       # NRPE
EOD

/usr/local/nagios/libexec/check_nrpe -H localhost