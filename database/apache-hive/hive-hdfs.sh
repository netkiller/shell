su - hadoop
/srv/apache-hadoop/bin/hdfs dfs -mkdir -p /user/hive/warehouse
/srv/apache-hadoop/bin/hdfs dfs -mkdir -p /tmp/hive
/srv/apache-hadoop/bin/hdfs dfs -chmod g+w /user/hive/warehouse
/srv/apache-hadoop/bin/hdfs dfs -chmod 777 /tmp/hive
