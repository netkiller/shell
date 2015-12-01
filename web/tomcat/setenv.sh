
cat > /srv/apache-tomcat/bin/setenv.sh <<'EOF'
export JRE_HOME=/srv/java
export JAVA_HOME=/srv/java
export JAVA_OPTS="-server -Xms512m -Xmx8192m"

export CATALINA_HOME=/srv/apache-tomcat
export CATALINA_TMPDIR=/var/tmp
#export CATALINA_OPTS="-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=9012 -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=true"

export CLASSPATH=$JAVA_HOME/lib:$JAVA_HOME/jre/lib:$CATALINA_HOME/lib:
export PATH=$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$CATALINA_HOME/bin:

EOF
