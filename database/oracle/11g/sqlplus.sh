#!/bin/bash

yum localinstall -y oracle-instantclient11.2-*	

cat >> ~/.bash_profile <<EOF

# Oracle SQLPlus Backspace<Key>
stty erase ^h
ORACLE_HOME=/usr/lib/oracle/11.2/client64
PATH=$ORACLE_HOME/bin:$PATH
LD_LIBRARY_PATH=$ORACLE_HOME/lib
export ORACLE_HOME
export LD_LIBRARY_PATH
export TNS_ADMIN=$ORACLE_HOME/network/admin
export PATH
EOF


mkdir -p /usr/lib/oracle/11.2/client64/network/admin

wget -O /usr/lib/oracle/11.2/client64/network/admin/glogin.sql https://raw.githubusercontent.com/oscm/shell/master/database/oracle/glogin.sql

cat >> /usr/lib/oracle/11.2/client64/network/admin/tnsnames.ora <<EOF
XXX =
   (DESCRIPTION =
     (ADDRESS = (PROTOCOL = TCP)(HOST = 172.16.0.2)(PORT = 1521))
     (CONNECT_DATA =
       (SERVER = DEDICATED)
       (SERVICE_NAME = DB)
     )
   )
EOF

# sqlplus user/pass@XXX