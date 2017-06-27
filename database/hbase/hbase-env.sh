cat > /srv/apache-hbase/bin/hbase-env.sh <<EOF
export JAVA_HOME=/srv/java
#export HBASE_CLASSPATH=
export HBASE_MANAGES_ZK=true
EOF
