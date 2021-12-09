dnf remove -y nodejs

cd /usr/local/src
wget https://nodejs.org/dist/v17.2.0/node-v17.2.0-linux-x64.tar.xz
tar xf node-v17.2.0-linux-x64.tar.xz
mv node-v17.2.0-linux-x64 /srv/node-v17.2.0
rm -f /srv/node
ln -s /srv/node-v17.2.0 /srv/node

alternatives --install /usr/local/bin/node node /srv/node/bin/node 100 \
--slave /usr/local/bin/npm npm /srv/node/bin/npm \
--slave /usr/local/bin/npx npx /srv/node/bin/npx \
--slave /usr/local/bin/corepack corepack /srv/node/bin/corepack

node -v

#alternatives --remove node /srv/node-v12.4.0/bin/node