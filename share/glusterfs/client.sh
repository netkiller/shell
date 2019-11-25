#!/bin/bash

wget http://download.gluster.org/pub/gluster/glusterfs/3.5/3.5.2/CentOS/glusterfs-epel.repo -P /etc/dnf.repos.d/
dnf install -y glusterfs-client


