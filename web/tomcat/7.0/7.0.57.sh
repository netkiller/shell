#!/bin/bash

if [ -z "$( egrep "CentOS|Redhat" /etc/issue)" ]; then
	echo 'Only for Redhat or CentOS'
	exit
fi

cd /usr/local/src/
wget http://ftp.cuhk.edu.hk/pub/packages/apache.org/tomcat/tomcat-7/v7.0.57/bin/apache-tomcat-7.0.57.tar.gz
tar zxf apache-tomcat-7.0.57.tar.gz 

mv apache-tomcat-7.0.57 /srv/
ln -s /srv/apache-tomcat-7.0.57 /srv/apache-tomcat
rm -rf /srv/apache-tomcat/webapps/*
rm -rf /srv/apache-tomcat/logs/*

cat > /srv/apache-tomcat/bin/setenv.sh <<'EOF'
export JAVA_HOME=/srv/java
export JAVA_OPTS="-server -Xms512m -Xmx8192m  -XX:PermSize=64M -XX:MaxPermSize=512m"
export CATALINA_HOME=/srv/apache-tomcat
export CLASSPATH=$JAVA_HOME/lib:$JAVA_HOME/jre/lib:$CATALINA_HOME/lib:/srv/IngrianJCE/lib/ext/IngrianNAE-5.1.1.jar
export PATH=$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$CATALINA_HOME/bin:
EOF

cp /srv/apache-tomcat/conf/server.xml{,.original}

vim /srv/apache-tomcat/conf/server.xml <<VIM > /dev/null 2>&1
:73,73s:/>:maxThreads="4096" enableLookups="false" compression="on" compressionMinSize="2048" compressableMimeType="text/html,text/xml,text/javascript,text/css,text/plain,,application/octet-stream" server="Apache"/>:
:126,126s/true/false/g
:93s/</<!-- </
:93s/>/> -->/
:wq
VIM


groupadd -g 80 www
adduser -o --home /www --uid 80 --gid 80 -c "Web Application" www

chown www:www -R /srv/*

su - www -c "/srv/apache-tomcat/bin/startup.sh"