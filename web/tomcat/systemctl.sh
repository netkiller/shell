#!/bin/bash

wget -q https://raw.githubusercontent.com/netkiller/shell/master/web/tomcat/systemd/tomcat.service -O /usr/lib/systemd/system/tomcat.service
systemctl enable tomcat
systemctl start tomcat
