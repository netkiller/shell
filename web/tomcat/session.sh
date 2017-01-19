# Java 8 + Tomcat 8 session manager to store sessions in Redis.

git clone https://github.com/netkiller/redis-session-manager.git
cd redis-session-manager
mvn package
mvn dependency:copy-dependencies

cp target/redis-session-manager-2.1.1-SNAPSHOT.jar /srv/apache-tomcat/lib
cp target/dependency/redisson-3.2.2.jar /srv/apache-tomcat/lib