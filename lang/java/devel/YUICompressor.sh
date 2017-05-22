#!/bin/bash

cd /usr/local/src/
wget https://github.com/yui/yuicompressor/releases/download/v2.4.8/yuicompressor-2.4.8.jar
mv yuicompressor-2.4.8.jar /usr/local/libexec/

cat >> /usr/local/bin/yuicompressor <<'EOF'
java -jar /usr/local/libexec/yuicompressor-2.4.8.jar $@
EOF

chmod +x /usr/local/bin/yuicompressor


