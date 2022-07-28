#!/bin/sh
#############################################
# netkiller - http://www.netkiller.cn
# Author: Neo <netkiller@msn.com>
#############################################

if [ ! -f /usr/bin/expect ]; then
dnf install -y expect
fi

/usr/bin/expect <<EOF
set timeout 30
#set host [lindex $argv 0]
#set password [lindex $argv 1]
#set done 0
 
set disk '/dev/vdb'
#spawn fdisk $disk
spawn fdisk /dev/vdb
expect "Command (m for help):"
send "n\r"

expect "Select (default p):"
send "p\r"
expect "Partition number (1-4, default 1):"
send "\r"
expect "First sector"
send "\r"
expect "Last sector, +sectors or +size{K,M,G}"
send "\r"

expect "Command (m for help):" 
send "p\r"

expect "Command (m for help):"
send "w\r"
expect eof
exit

EOF

mkfs.btrfs -L /srv -f /dev/vdb1
