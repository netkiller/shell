
cat > /srv/apache-hbase/conf/hbase-site.xml <<"EOF"
<?xml version="1.0"?>  
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
    <property>
        <name>hbase.cluster.distributed</name>
        <value>true</value>
    </property>
	<property>
		<name>hbase.rootdir</name>
		<value>hdfs://localhost:9000/hbase</value>
	</property>
</configuration>
EOF

chown hadoop:hadoop -R /srv/apache-hbase-1.2.6
