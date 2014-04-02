tar zxvf Python-3.4.0.tgz 
cd Python-3.4.0
./configure --prefix=/srv/python-3.4.0
make -j8
make install

ln -s /srv/python-3.4.0 /srv/python

cat >> ~/.bashrc <<EOF
PATH=$PATH:/srv/python/bin:
EOF
