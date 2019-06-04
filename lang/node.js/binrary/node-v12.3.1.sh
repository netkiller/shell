yum remove -y nodejs

cd /usr/local/src
wget https://nodejs.org/dist/v12.3.1/node-v12.3.1-linux-x64.tar.xz
tar xf node-v12.3.1-linux-x64.tar.xz
mv node-v12.3.1-linux-x64 /srv/node-v12.3.1
rm -f /srv/node
ln -s /srv/node-v12.3.1 /srv/node

alternatives --install /usr/local/bin/node node /srv/node-v12.3.1/bin/node 100