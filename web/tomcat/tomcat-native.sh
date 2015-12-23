#!/bin/bash

#vim /srv/apache-tomcat/conf/server.xml <<VIM > /dev/null 2>&1
#:wq
#VIM

sed -i "71s#HTTP/1.1#org.apache.coyote.http11.Http11AprProtocol#" /srv/apache-tomcat/conf/server.xml