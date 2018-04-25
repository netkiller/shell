cd /usr/local/src
wget https://nodejs.org/dist/v9.11.1/node-v9.11.1-linux-x64.tar.xz
tar xf node-v9.11.1-linux-x64.tar.xz
mv node-v9.11.1-linux-x64 /srv/node-v9.11.1
rm -f /srv/node
ln -s /srv/node-v9.11.1 /srv/node
