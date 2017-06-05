
cd /usr/local/src
wget https://nodejs.org/dist/v7.10.0/node-v7.10.0-linux-x64.tar.xz
tar xf node-v7.10.0-linux-x64.tar.xz
mv node-v7.10.0-linux-x64 /srv/
rm -f /srv/node
ln -s /srv/node-v7.10.0-linux-x64 /srv/node