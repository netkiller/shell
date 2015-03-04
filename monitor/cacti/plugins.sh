#!/bin/bash

cd /usr/local/src
wget http://docs.cacti.net/_media/plugin:monitor-v1.3-1.tgz
wget http://docs.cacti.net/_media/plugin:errorimage-v0.2-1.tgz
wget http://docs.cacti.net/_media/plugin:discovery-v1.5-1.tgz
wget http://docs.cacti.net/_media/plugin:ntop-v0.2-1.tgz

mv plugin\:monitor-v1.3-1.tgz monitor-v1.3-1.tgz
mv plugin\:errorimage-v0.2-1.tgz errorimage-v0.2-1.tgz 
mv plugin\:ntop-v0.2-1.tgz ntop-v0.2-1.tgz 

tar zxf monitor-v1.3-1.tgz -C /usr/share/cacti/plugins
tar zxf errorimage-v0.2-1.tgz -C /usr/share/cacti/plugins
tar zxf ntop-v0.2-1.tgz -C /usr/share/cacti/plugins
