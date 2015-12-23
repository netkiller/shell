
cat > /srv/apache-tomcat/bin/setenv.sh <<'EOF'
export JRE_HOME=/srv/java
export JAVA_HOME=/srv/java
export JAVA_OPTS="-server -Xms1024m -Xmx8192m"

export CATALINA_HOME=/srv/apache-tomcat
export LD_LIBRARY_PATH=/srv/apache-tomcat/lib
export CATALINA_OPTS="$JAVA_OPTS -Djava.awt.headless=true -Djava.library.path=$LD_LIBRARY_PATH"
#export CATALINA_OPTS="-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=9012 -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=true"
#export CATALINA_TMPDIR=/var/tmp


export CLASSPATH=$JAVA_HOME/lib:$CATALINA_HOME/lib:
export PATH=$PATH:$JAVA_HOME/bin:$CATALINA_HOME/bin:

EOF
