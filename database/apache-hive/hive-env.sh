cat > /srv/apache-hive/conf/hive-env.sh <<EOF
export JAVA_HOME=/srv/java
export HADOOP_HOME=/srv/apache-hadoop
export HIVE_HOME=/srv/apache-hive
export PATH=$PATH:$JAVA_HOME/bin:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$HIVE_HOME/bin
EOF
