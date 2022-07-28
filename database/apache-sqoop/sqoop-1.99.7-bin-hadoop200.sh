cd /usr/local/src

# MySQL

curl -s https://raw.githubusercontent.com/netkiller/shell/master/database/mysql/5.7/mysql57-community-release-el7-11.sh | bash
curl -s https://raw.githubusercontent.com/netkiller/shell/master/database/mysql/5.7/mysql-connector-java.sh | bash

wget https://mirrors.tuna.tsinghua.edu.cn/apache/sqoop/1.99.7/sqoop-1.99.7-bin-hadoop200.tar.gz

tar zxf sqoop-1.99.7-bin-hadoop200.tar.gz
mv sqoop-1.99.7-bin-hadoop200 /srv/apache-sqoop-1.99.7-bin-hadoop200
ln -s /srv/apache-sqoop-1.99.7-bin-hadoop200 /srv/apache-sqoop
cp /srv/apache-sqoop/conf/sqoop.properties{,.original}

chown hadoop:hadoop -R /srv/apache-sqoop*

cat > /srv/apache-sqoop/conf/sqoop-env.sh <<'EOF'
export HADOOP_HOME=/srv/apache-hadoop
#export HADOOP_COMMON_HOME=$HADOOP_HOME
#export HADOOP_HDFS_HOME=$HADOOP_HOME/share/hadoop/hdfs
#export HADOOP_YARN_HOME=$HADOOP_HOME/share/hadoop/yarn
#export HADOOP_MAPRED_HOME=$HADOOP_HOME/share/hadoop/mapreduce
EOF

cat >> ~/.bash_profile <<'EOF'
export HADOOP_HOME=/srv/apache-hadoop
export JAVA_LIBRARY_PATH=$HADOOP_HOME/lib/native
export SQOOP_HOME=/srv/apache-sqoop
export CATALINA_HOME=$SQOOP_HOME/server
export LOGDIR=$SQOOP_HOME/logs
#export PATH=$SQOOP_HOME/bin:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$PATH
export PATH=$SQOOP_HOME/bin:$PATH:
EOF

source ~/.bash_profile

# Hadoop configuration directory
# org.apache.sqoop.submission.engine.mapreduce.configuration.directory=/etc/hadoop/conf/
sed -i "144s|/etc/hadoop/conf/|/srv/apache-hadoop/etc/hadoop|" /srv/apache-sqoop/conf/sqoop.properties

#sed -i "958s|||" /srv/apache-sqoop/conf/sqoop.properties
#sed -i "486s|||" /srv/apache-sqoop/conf/sqoop.properties

ln -s /usr/share/java/mysql-connector-java.jar /srv/apache-sqoop/server/lib/

/srv/apache-sqoop/bin/sqoop.sh server start
