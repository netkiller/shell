#!/bin/bash

cp $JAVA_HOME/jre/lib/management/snmp.acl.template $JAVA_HOME/jre/lib/management/snmp.acl

cat >> $JAVA_HOME/jre/lib/management/snmp.acl <<EOD

acl = {
 {
   communities = public
   access = read-only
   managers = localhost
 }
}
EOD


test -f /etc/snmp/snmp.local.conf && cp /etc/snmp/snmp.local.conf{,.original}

cat >> /etc/snmp/snmp.local.conf <<EOD

#JVM-MANAGEMENT-MIB
proxy -v 2c -c public localhost:9004 .1.3.6.1.4.1.42
EOD

# Enable SNMP on JVM - Add the following argument when starting JVM 
# -Dcom.sun.management.snmp.port=9998 