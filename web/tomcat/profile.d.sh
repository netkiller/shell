
cat >> /etc/profile.d/apache-tomcat.sh <<'EOF'
export CATALINA_HOME=/srv/apache-tomcat
export CLASSPATH=$JAVA_HOME/lib:$JAVA_HOME/jre/lib:$CATALINA_HOME/lib:
EOF