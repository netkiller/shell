
sudo cp /etc/udhcpd.conf{,.original}

sudo vim /etc/udhcpd.conf
start 192.168.0.20
end 192.168.0.200
interface wlan0