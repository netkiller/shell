cd /tmp

wget https://github.com/rancher/rancher-compose/releases/download/v0.12.5/rancher-compose-linux-amd64-v0.12.5.tar.xz
tar Jxvf rancher-compose-linux-amd64-v0.12.5.tar.xz
#mkdir /srv/rancher/
mv ./rancher-compose-v0.12.5/rancher-compose /usr/local/bin/

cd