#!/bin/bash

wget -q https://raw.githubusercontent.com/oscm/shell/master/web/tomcat/init.d/tomcat -O /etc/init.d/tomcat
chmod +x /etc/init.d/tomcat
chkconfig tomcat on
