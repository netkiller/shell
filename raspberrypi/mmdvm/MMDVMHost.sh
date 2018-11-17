
sudo mkdir -p /srv/mmdvm/{bin,etc}

sudo useradd mmdvm -s /sbin/nologin
sudo usermod mmdvm -G dialout

cd /usr/local/src 
git clone https://github.com/g4klx/MMDVMHost.git
cd MMDVMHost
make

sudo cp MMDVMHost /srv/mmdvm/bin 
sudo cp MMDVM.ini /srv/mmdvm/etc 
sudo cp DMRIds.dat /srv/mmdvm/etc
sudo cp NXDN.csv /srv/mmdvm/etc
sudo cp RSSI.dat /srv/mmdvm/etc