#!/bin/bash

dnf install -y java-1.8.0-openjdk

cat >> /etc/profile.d/java.sh <<'EOF'
export JAVA_HOME=/etc/alternatives/jre
export JAVA_OPTS="-server -Xms2048m -Xmx4096m -Djava.io.tmpdir=/tmp -Djava.security.egd=file:/dev/./urandom -Dfile.encoding=UTF8  -Duser.timezone=GMT+08"
export CLASSPATH=$JAVA_HOME/lib:$JAVA_HOME/jre/lib:.
export PATH=$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin:
EOF

source /etc/profile.d/java.sh


sed -i "117s|securerandom.source=file:/dev/random|securerandom.source=file:/dev/urandom|" /usr/lib/jvm/jre-1.8.0/lib/security/java.security