cd /usr/local/src 
git clone https://github.com/g4klx/MMDVMCal.git
cd MMDVMCal
make

sudo cp MMDVMCal /srv/mmdvm/bin

# sudo /srv/mmdvm/bin/MMDVMCal /dev/ttyACM0