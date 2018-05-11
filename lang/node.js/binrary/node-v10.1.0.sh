cd /usr/local/src
wget https://nodejs.org/dist/v10.1.0/node-v10.1.0-linux-x64.tar.xz
tar xf node-v10.1.0-linux-x64.tar.xz
mv node-v10.1.0-linux-x64 /srv/node-v10.1.0
rm -f /srv/node
ln -s /srv/node-v10.1.0 /srv/node