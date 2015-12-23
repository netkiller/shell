
cat > /srv/apache-tomcat/bin/setenv.sh <<'EOF'
export JRE_HOME=/srv/java
export JAVA_HOME=/srv/java
export JAVA_OPTS="-server -Xms1024M -Xmx4096M"

export CATALINA_HOME=/srv/apache-tomcat
export CATALINA_OPTS="$JAVA_OPTS -XX:PermSize=256M -XX:MaxNewSize=1024M -XX:MaxPermSize=512M -Djava.awt.headless=true"
#export CATALINA_OPTS="-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=9012 -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=true -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager"
#export CATALINA_TMPDIR=/var/tmp

export CLASSPATH=$JAVA_HOME/lib:$JAVA_HOME/jre/lib:$CATALINA_HOME/lib:
export PATH=$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$CATALINA_HOME/bin:

EOF
