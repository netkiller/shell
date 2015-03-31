#!/bin/bash

cp $JAVA_HOME/jre/lib/management/jmxremote.password.template $JAVA_HOME/jre/lib/management/jmxremote.password

cat >> $JAVA_HOME/jre/lib/management/jmxremote.password <<EOD

monitorRole tomcat
controlRole tomcat
EOD

chmod 600 $JAVA_HOME/jre/lib/management/jmxremote.password

test -f $JAVA_HOME/jre/lib/management/jmxremote.access && cp $JAVA_HOME/jre/lib/management/jmxremote.access{,.original}

#cat >> $JAVA_HOME/jre/lib/management/jmxremote.access <<EOD

#monitorRole   readonly
#controlRole   readwrite
#EOD

# Enable Jmx on JVM - Add the following argument when starting JVM 
#-Dcom.sun.management.jmxremote \
#-Dcom.sun.management.jmxremote.port=9012 \
#-Dcom.sun.management.jmxremote.ssl=false \
#-Dcom.sun.management.jmxremote.authenticate=false \

#-Dcom.sun.management.jmxremote.authenticate=true
#-Dcom.sun.management.jmxremote.password.file=../conf/jmxremote.password
#-Dcom.sun.management.jmxremote.access.file=../conf/jmxremote.access