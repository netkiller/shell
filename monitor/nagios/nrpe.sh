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
nagios-plugins-users \
nagios-plugins-tcp \
nagios-plugins-time \
nagios-plugins-http \
nagios-plugins-openmanage 

#nagios-plugins-dig \
#nagios-plugins-dns \
#nagios-plugins-ntp \
#nagios-plugins-smtp \
#nagios-plugins-snmp \
#nagios-plugins-ssh \
#nagios-plugins-mysql \
 

cp /etc/nagios/nrpe.cfg{,.original}

# CentOS 6.5
#vim /etc/nagios/nrpe.cfg <<VIM > /dev/null 2>&1
#:%s/dont_blame_nrpe=0/dont_blame_nrpe=1/
#:210,214s/command/#command/
#:wq
#VIM

# CentOS 6.6
vim /etc/nagios/nrpe.cfg <<VIM > /dev/null 2>&1
:%s/dont_blame_nrpe=0/dont_blame_nrpe=1/
:210,214s/command/#command/
:wq
VIM
#:%s/allowed_hosts=127.0.0.1/allowed_hosts=172.16.1.2/
echo "include_dir=/etc/nagios/nrpe.d/" >> /etc/nagios/nrpe.cfg 
mkdir /etc/nagios/nrpe.d/

#cat > /etc/nrpe.d/plugins.cfg <<'EOF'
cat > /etc/nagios/nrpe.d/plugins.cfg <<'EOF'
command[check_swap]=/usr/lib64/nagios/plugins/check_swap -w $ARG1$ -c $ARG2$
command[check_disk]=/usr/lib64/nagios/plugins/check_disk -w $ARG1$ -c $ARG2$ -p $ARG3$
command[check_all_disks]=/usr/lib64/nagios/plugins/check_disk -w $ARG1$ -c $ARG2$ -e
command[check_users]=/usr/lib64/nagios/plugins/check_users -w $ARG1$ -c $ARG2$
command[check_load]=/usr/lib64/nagios/plugins/check_load -w $ARG1$ -c $ARG2$
command[check_zombie_procs]=/usr/lib64/nagios/plugins/check_procs -w $ARG1$ -c $ARG2$ -s Z
command[check_total_procs]=/usr/lib64/nagios/plugins/check_procs -w $ARG1$ -c $ARG2$ 
command[check_procs]=/usr/lib64/nagios/plugins/check_procs -w $ARG1$ -c $ARG2$ -s $ARG3$
command[check_procs_command]=/usr/lib64/nagios/plugins/check_procs -w $ARG1$ -c $ARG2$ -C $ARG3$
command[check_tcp]=/usr/lib64/nagios/plugins/check_tcp -w $ARG1$ -c $ARG2$ -H $ARG3$ -p $ARG4$
command[check_http]=/usr/lib64/nagios/plugins/check_http -w $ARG1$ -c $ARG2$ -H $ARG3$ -p $ARG4$
command[check_log]=/usr/lib64/nagios/plugins/check_log -F $ARG1$ -O /tmp/$ARG1$.old -q $ARG2$

EOF

chkconfig nrpe on
service nrpe start

# check_nrpe -H localhost
# NRPE v2.15