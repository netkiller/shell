#!/bin/bash

dnf install openvpn -y
chkconfig openvpn on

cp /usr/share/doc/openvpn-2.3.2/sample/sample-config-files/client.conf /etc/openvpn/

service openvpn start