cd /usr/local/src
wget http://mirrors.tuna.tsinghua.edu.cn/apache/flume/1.7.0/apache-flume-1.7.0-bin.tar.gz
tar zxf apache-flume-1.7.0-bin.tar.gz
cp apache-flume-1.7.0-bin/conf/flume-env.sh.template apache-flume-1.7.0-bin/conf/flume-env.sh
cp apache-flume-1.7.0-bin/conf/flume-conf.properties.template apache-flume-1.7.0-bin/conf/flume-conf.properties


cat >> apache-flume-1.7.0-bin/conf/flume-env.sh <<EOF
export JAVA_HOME=/srv/java
export JAVA_OPTS="-server -Xms100m -Xmx2000m -Djava.security.egd=file:/dev/./urandom -Dfile.encoding=UTF8  -Duser.timezone=GMT+08"
EOF

mv apache-flume-1.7.0-bin /srv/apache-flume-1.7.0
ln -s /srv/apache-flume-1.7.0 /srv/apache-flume
