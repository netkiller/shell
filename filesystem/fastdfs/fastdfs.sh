#!/bin/bash

wget https://fastdfs.googlecode.com/files/FastDFS_v4.06.tar.gz
tar zxf FastDFS_v4.06.tar.gz 
cd FastDFS
yum install -y libevent-devel
./make.sh 
./make.sh install