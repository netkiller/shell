
cd /usr/local/src/
wget http://libcode.org/attachments/download/66/klish-2.1.3.tar.xz
tar jxvf klish-2.1.3.tar.xz
xz -d klish-2.1.3.tar.xz
tar xf klish-2.1.3.tar
cd klish-2.1.3
./configure --prefix=/srv/klish-2.1.3
make && make install

cp -r xml-examples /srv/klish-2.1.3/
export CLISH_PATH=/srv/klish-2.1.3/xml-examples/clish

ln -s /srv/klish-2.1.3 /srv/klish

