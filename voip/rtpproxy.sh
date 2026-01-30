cd /usr/local/src/
git clone -b master https://github.com/sippy/rtpproxy.git
git -C rtpproxy submodule update --init --recursive
cd rtpproxy
./configure
make && make install

groupadd --system rtpproxy
useradd -s /sbin/nologin --system -g rtpproxy rtpproxy

cp rpm/rtpproxy.sysconfig /etc/sysconfig/rtpproxy
cp rpm/rtpproxy.socket /etc/systemd/system/
cp rpm/rtpproxy.service /etc/systemd/system/

mkdir /var/run/rtpproxy
chown rtpproxy:rtpproxy /var/run/rtpproxy

systemctl start rtpproxy.socket
systemctl start rtpproxy.service
