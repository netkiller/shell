dnf remove -y nodejs

cd /usr/local/src
wget https://nodejs.org/dist/v16.13.1/node-v16.13.1-linux-x64.tar.xz
tar xf node-v16.13.1-linux-x64.tar.xz
mv node-v16.13.1-linux-x64 /srv/node-v16.13.1
rm -f /srv/node
ln -s /srv/node-v16.13.1 /srv/node

alternatives --install /usr/local/bin/node node /srv/node/bin/node 100 \
--slave /usr/local/bin/npm npm /srv/node/bin/npm \
--slave /usr/local/bin/npx npx /srv/node/bin/npx \
--slave /usr/local/bin/corepack corepack /srv/node/bin/corepack

node -v

#alternatives --remove node /srv/node-v12.4.0/bin/node