#!/bin/bash

wget http://download.gluster.org/pub/gluster/glusterfs/3.5/3.5.2/CentOS/glusterfs-epel.repo -P /etc/yum.repos.d/
yum install -y glusterfs-server
chkconfig glusterd on
service glusterd start


