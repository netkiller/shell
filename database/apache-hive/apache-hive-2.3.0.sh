cd /usr/local/src
wget http://mirrors.hust.edu.cn/apache/hive/stable-2/apache-hive-2.3.0-bin.tar.gz

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

sed -i "501s|jdbc:derby:;databaseName=metastore_db;create=true|jdbc:mysql://localhost:3306/hive?createDatabaseIfNotExist=true\&amp;characterEncoding=UTF-8\&amp;useSSL=false|" /srv/apache-hive/conf/hive-site.xml
sed -i "933s|org.apache.derby.jdbc.EmbeddedDriver|com.mysql.jdbc.Driver|" /srv/apache-hive/conf/hive-site.xml
sed -i "958s|APP|hive|" /srv/apache-hive/conf/hive-site.xml
sed -i "486s|mine|hive|" /srv/apache-hive/conf/hive-site.xml

