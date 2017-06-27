cat > /srv/hbase/conf/hbase-site.xml <<EOF
<?xml version="1.0"?>  
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>  
<configuration>  
	<property>  
		<name>hbase.rootdir</name>  
		<value>file:///tmp/hbase</value>  
	</property>  
</configuration>
EOF
