#!/bin/bash

while read file
do
	chmod 0700 $file
	chown root:root $file
done << EOF
/bin/rm
/bin/mv
/bin/chmod
/bin/chown
EOF

cat >> /etc/bashrc <<EOF
# Administrator specific aliases and functions for system security
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "
EOF

for user in $(ls -1 /home) 
do 
	if [ -e /home/$user/.bashrc ]; then 
		cat >> ~/.bashrc <<EOF
# Administrator specific aliases and functions for root security
alias rm='/bin/false'
EOF
	fi
done