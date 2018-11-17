
git clone https://github.com/g4klx/YSFClients.git
cd YSFClients/YSFGateway
make
sudo cp YSFGateway /srv/mmdvm/bin
sudo cp YSFGateway.ini /srv/mmdvm/etc
sudo cp FCSRooms.txt  YSFHosts.txt /srv/mmdvm/etc

sudo cp YSFHostsupdate.sh /srv/mmdvm/bin
sudo chmod +x /srv/mmdvm/bin/YSFHostsupdate.sh

cd ../YSFParrot
make
sudo cp YSFParrot /srv/mmdvm/bin

cd ../YSFReflector
make
sudo cp YSFReflector /srv/mmdvm/bin
sudo cp YSFReflector.ini /srv/mmdvm/etc

sudo cp YSFReflector.sh /srv/mmdvm/bin 
sudo chmod +x /srv/mmdvm/bin/YSFReflector.sh 