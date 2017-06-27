cp /srv/apache-hbase/conf/hbase-env.sh{,.original}
cat > /srv/apache-hbase/conf/hbase-env.sh <<EOF
export JAVA_HOME=/srv/java
#export HBASE_CLASSPATH=
export HBASE_MANAGES_ZK=true
EOF
