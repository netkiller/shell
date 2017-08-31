cd /usr/local/src

curl -s https://raw.githubusercontent.com/oscm/shell/master/database/mysql/5.7/mysql57-community-release-el7-11.sh | bash
curl -s https://raw.githubusercontent.com/oscm/shell/master/database/mysql/5.7/mysql-connector-java.sh | bash

wget http://mirror.bit.edu.cn/apache/hive/hive-2.3.0/apache-hive-2.3.0-bin.tar.gz

tar zxf apache-hive-2.3.0-bin.tar.gz
mv apache-hive-2.3.0-bin /srv/apache-hive-2.3.0
ln -s /srv/apache-hive-2.3.0/ /srv/apache-hive

cd /srv/apache-hive/conf
cp hive-env.sh.template hive-env.sh
cp hive-default.xml.template hive-site.xml
cp hive-log4j2.properties.template hive-log4j2.properties
cp hive-exec-log4j2.properties.template hive-exec-log4j2.properties
cd -

chown hadoop:hadoop -R /srv/apache-hive-2.3.0

sed -i "s|\${system:java.io.tmpdir}/\${system:user.name}|/tmp/hive/hadoop|g" /srv/apache-hive/conf/hive-site.xml

sed -i "s|\${system:java.io.tmpdir}|/tmp/hive|g" /srv/apache-hive/conf/hive-site.xml

sed -i "545s|jdbc:derby:;databaseName=metastore_db;create=true|jdbc:mysql://localhost:3306/hive?createDatabaseIfNotExist=true\&amp;characterEncoding=UTF-8\&amp;useSSL=false|" /srv/apache-hive/conf/hive-site.xml
sed -i "1020s|org.apache.derby.jdbc.EmbeddedDriver|com.mysql.jdbc.Driver|" /srv/apache-hive/conf/hive-site.xml
sed -i "1045s|APP|hive|" /srv/apache-hive/conf/hive-site.xml
sed -i "530s|mine|hive|" /srv/apache-hive/conf/hive-site.xml

ln -s  /usr/share/java/mysql-connector-java.jar /srv/apache-hive/lib/

/srv/apache-hive/bin/schematool -dbType mysql -initSchema
