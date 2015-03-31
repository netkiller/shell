#!/bin/bash

cd /usr/local/src/
wget http://ftp.cuhk.edu.hk/pub/packages/apache.org/tomcat/tomcat-8/v8.0.21/bin/apache-tomcat-8.0.21.tar.gz
tar zxf apache-tomcat-8.0.21.tar.gz 

mv apache-tomcat-8.0.21 /srv/
ln -s /srv/apache-tomcat-8.0.21 /srv/apache-tomcat
#rm -rf /srv/apache-tomcat/webapps/*
rm -rf  /srv/apache-tomcat/webapps/{docs,examples,host-manager,ROOT/*}
rm -rf /srv/apache-tomcat/logs/*

cp /srv/apache-tomcat/conf/server.xml{,.original}

vim /srv/apache-tomcat/conf/server.xml <<VIM > /dev/null 2>&1
:71,71s:/>:maxThreads="4096" enableLookups="false" compression="on" compressionMinSize="2048" compressableMimeType="text/html,text/xml,text/javascript,text/css,text/plain,,application/octet-stream" server="Apache"/>:
:91s/</<!-- </
:91s/>/> -->/
:124,124s/true/false/g
:wq
VIM

cat > /srv/apache-tomcat/bin/setenv.sh <<'EOF'
export JAVA_HOME=/srv/java
export JAVA_OPTS="-server -Xms512m -Xmx8192m"
export CLASSPATH=$JAVA_HOME/lib:$JAVA_HOME/jre/lib:$CATALINA_HOME/lib:
export PATH=$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$CATALINA_HOME/bin:

export CATALINA_HOME=/srv/apache-tomcat
export CATALINA_TMPDIR=/var/tmp
export CATALINA_OPTS="-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=9012 -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=true"

EOF

cat >> ~/.bash_profile <<'EOF'
export CATALINA_HOME=/srv/apache-tomcat
export CLASSPATH=$JAVA_HOME/lib:$JAVA_HOME/jre/lib:$CATALINA_HOME/lib:
EOF

groupadd -g 80 www
adduser -o --home /www --uid 80 --gid 80 -c "Web Application" www
chown www:www -R /srv/apache-tomcat-*

su - www -c "/srv/apache-tomcat/bin/startup.sh"

# Daemon Script
# cp /srv/apache-tomcat/bin/daemon.sh /etc/init.d/tomcat
# chmod +x /etc/init.d/tomcat