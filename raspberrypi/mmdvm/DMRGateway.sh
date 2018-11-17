cd /usr/local/src
git clone https://github.com/g4klx/DMRGateway.git
cd DMRGateway
make
sudo cp DMRGateway /srv/mmdvm/bin
sudo cp DMRGateway.ini /srv/mmdvm/etc

sudo cp XLXHostsupdate.sh /srv/mmdvm/bin
sudo chmod +x /srv/mmdvm/bin/XLXHostsupdate.sh