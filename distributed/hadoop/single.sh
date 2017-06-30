#hostnamectl set-hostname master

mkdir -p /opt/hadoop/volume/{namenode,datanode}
chown -R hadoop:hadoop /srv/apache-hadoop* /opt/hadoop

cp /srv/apache-hadoop/etc/hadoop/hadoop-env.sh{,.original}
sed -i "25s:\${JAVA_HOME}:/usr/java/default:" hadoop-env.sh

cp /srv/apache-hadoop/etc/hadoop/core-site.xml{,.original}

cat > /srv/apache-hadoop/etc/hadoop/core-site.xml <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
	<property>
		<name>fs.defaultFS</name>
		<value>hdfs://localhost:9000/</value>
	</property>	
</configuration>
EOF

cp /srv/apache-hadoop/etc/hadoop/hdfs-site.xml{,.original}

cat > /srv/apache-hadoop/etc/hadoop/hdfs-site.xml <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
	<property>
		<name>dfs.data.dir</name>
		<value>file:///opt/hadoop/volume/datanode</value>
	</property>
	<property>
		<name>dfs.name.dir</name>
		<value>file:///opt/hadoop/volume/namenode</value>
	</property>
</configuration>
EOF

cp /srv/apache-hadoop/etc/hadoop/mapred-site.xml{,.original}

cat > /srv/apache-hadoop/etc/hadoop/mapred-site.xml <<"EOF"
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
	<property>
		<name>mapreduce.framework.name</name>
		<value>yarn</value>
	</property>
</configuration>
EOF

 
cp /srv/apache-hadoop/etc/hadoop/yarn-site.xml{,.original}

cat > /srv/apache-hadoop/etc/hadoop/yarn-site.xml <<"EOF"
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
	<property>
		<name>yarn.nodemanager.aux-services</name>
		<value>mapreduce_shuffle</value>
	</property>
</configuration>
EOF
