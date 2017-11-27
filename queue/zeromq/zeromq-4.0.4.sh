cd /usr/local/src/
wget http://download.zeromq.org/zeromq-4.0.4.tar.gz
tar zxf zeromq-4.0.4.tar.gz 
cd zeromq-4.0.4
./configure --prefix=/srv/zeromq-4.0.4
make && make install

echo /srv/zeromq-4.0.4/lib > /etc/ld.so.conf.d/srv.conf
ldconfig   
