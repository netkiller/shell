#!/bin/bash

wget https://fastdfs.googlecode.com/files/FastDFS_v4.06.tar.gz
tar zxf FastDFS_v4.06.tar.gz 
cd FastDFS
yum install -y libevent-devel
./make.sh 
./make.sh install

cd

cp /etc/fdfs/client.conf{,.original}
cp /etc/fdfs/http.conf{,.original}
cp /etc/fdfs/storage.conf{,.original}
cp /etc/fdfs/tracker.conf{,.original}

sed -i 's:base_path=/home/yuqing/fastdfs:base_path=/www/fastdfs:g' /etc/fdfs/client.conf 
sed -i 's/tracker_server=192.168.0.197:22122/tracker_server=127.0.0.1:22122/g' /etc/fdfs/client.conf 
sed -i 's:base_path=/home/yuqing/fastdfs:base_path=/www/fastdfs:g' /etc/fdfs/tracker.conf 
sed -i 's:base_path=/home/yuqing/fastdfs:base_path=/www/fastdfs:g' /etc/fdfs/storage.conf 
sed -i 's:store_path0=/home/yuqing/fastdfs:store_path0=/www/fastdfs:g' /etc/fdfs/storage.conf 
sed -i 's/tracker_server=192.168.209.121:22122/tracker_server=127.0.0.1:22122/g' /etc/fdfs/storage.conf 

##########################
# Test
##########################
# fdfs_trackerd /etc/fdfs/tracker.conf
# fdfs_storaged /etc/fdfs/storage.conf
# fdfs_upload_file /etc/fdfs/client.conf /etc/issue
# group1/M00/00/00/CvF8pVS2GziAcsCfAAAALysCLgI6731043
# fdfs_test /etc/fdfs/client.conf upload /etc/centos-release
##########################

