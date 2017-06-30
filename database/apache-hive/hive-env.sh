cp /srv/apache-hive/conf/hive-env.sh{,.original}

cat > /srv/apache-hive/conf/hive-env.sh <<'EOF'
export JAVA_HOME=/srv/java
export HADOOP_HOME=/srv/apache-hadoop
export HBASE_HOME=/srv/apache-hbase
export HIVE_HOME=/srv/apache-hive
export PATH=$PATH:$JAVA_HOME/bin:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$HBASE_HOME/bin:$HIVE_HOME/bin
EOF

cat >> ~/.bash_profile <<'EOF'
export JAVA_HOME=/srv/java
export HADOOP_HOME=/srv/apache-hadoop
export HBASE_HOME=/srv/apache-hbase
export HIVE_HOME=/srv/apache-hive
export PATH=$PATH:$JAVA_HOME/bin:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$HBASE_HOME/bin:$HIVE_HOME/bin
EOF

source ~/.bash_profile
