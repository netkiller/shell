#!/bin/bash

yum install -y nrpe 
#yum install -y nagios-plugins-all
yum install -y \
nagios-plugins-disk \
nagios-plugins-load \
nagios-plugins-log \
nagios-plugins-mailq \
nagios-plugins-procs \
nagios-plugins-swap \
nagios-plugins-users

#nagios-plugins-dig \
#nagios-plugins-dns \
#nagios-plugins-mysql \
#nagios-plugins-ntp \
#nagios-plugins-smtp \
#nagios-plugins-snmp \
#nagios-plugins-ssh \
#nagios-plugins-tcp \


cp /etc/nagios/nrpe.cfg{,.original}
vim /etc/nagios/nrpe.cfg <<VIM > /dev/null 2>&1
:%s/allowed_hosts=127.0.0.1/allowed_hosts=172.16.1.2/
:%s/dont_blame_nrpe=0/dont_blame_nrpe=1/
:210,214s/command/#command/
:wq
VIM

cat > /etc/nrpe.d/nrpe.cfg <<'EOF'
command[check_swap]=/usr/lib64/nagios/plugins/check_swap -w $ARG1$ -c $ARG2$
command[check_all_disks]=/usr/lib64/nagios/plugins/check_disk -w $ARG1$ -c $ARG2$ -e
command[check_users]=/usr/lib64/nagios/plugins/check_users -w $ARG1$ -c $ARG2$
command[check_load]=/usr/lib64/nagios/plugins/check_load -w $ARG1$ -c $ARG2$
command[check_zombie_procs]=/usr/lib64/nagios/plugins/check_procs -w $ARG1$ -c $ARG2$ -s Z
command[check_total_procs]=/usr/lib64/nagios/plugins/check_procs -w $ARG1$ -c $ARG2$ 
command[check_users]=/usr/lib64/nagios/plugins/check_users -w $ARG1$ -c $ARG2$
command[check_load]=/usr/lib64/nagios/plugins/check_load -w $ARG1$ -c $ARG2$
command[check_disk]=/usr/lib64/nagios/plugins/check_disk -w $ARG1$ -c $ARG2$ -p $ARG3$
command[check_procs]=/usr/lib64/nagios/plugins/check_procs -w $ARG1$ -c $ARG2$ -s $ARG3$
EOF

chkconfig nrpe on
service nrpe start

# check_nrpe -H localhost
# NRPE v2.15