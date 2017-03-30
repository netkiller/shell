# Java 8 + Tomcat 8 session manager to store sessions in Redis.
cd /usr/local/src

git clone https://github.com/chexagon/redis-session-manager.git
cd redis-session-manager
git checkout tomcat-8.5
mvn package
#mvn dependency:copy-dependencies

cp target/redis-session-manager-with-dependencies-2.1.0-SNAPSHOT.jar /srv/apache-tomcat/lib
#cp target/dependency/redisson-3.2.2.jar /srv/apache-tomcat/lib