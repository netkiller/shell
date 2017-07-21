curl -s https://raw.githubusercontent.com/oscm/shell/master/distributed/hadoop/hadoop-2.8.0.sh | bash

#hostnamectl set-hostname master

cp /srv/apache-hadoop/etc/hadoop/core-site.xml{,.original}

cat > /srv/apache-hadoop/etc/hadoop/core-site.xml <<'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
	<property>
		<name>fs.defaultFS</name>
		<value>hdfs://localhost:9000/</value>
	</property>
    <property>
        <name>hadoop.proxyuser.hadoop.groups</name>
        <value>*</value>
        <description>Allow the superuser oozie to impersonate any members of the group group1 and group2</description>
    </property>
    <property>
        <name>hadoop.proxyuser.hadoop.hosts</name>
        <value>*</value>
        <description>The superuser can connect only from host1 and host2 to impersonate a user</description>
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


