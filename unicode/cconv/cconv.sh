#!/bin/bash
cd /usr/local/src/
wget https://cconv.googlecode.com/files/cconv-0.6.2.tar.gz
tar zxf cconv-0.6.2.tar.gz 
cd cconv-0.6.2
./configure --prefix=/srv/cconv-0.6.2
make
make install

ln -s /srv/cconv-0.6.2 /srv/cconv
