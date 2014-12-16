#!/bin/sh
wget https://www.python.org/ftp/python/3.4.2/Python-3.4.2.tgz

tar zxf Python-3.4.2.tgz 
cd Python-3.4.2
./configure --prefix=/srv/python-3.4.2
make -j8
make install

ln -s /srv/python-3.4.2 /srv/python

cat >> ~/.bashrc <<EOF
PATH=$PATH:/srv/python/bin:
EOF
