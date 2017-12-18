sed -i "7,7 s/#server.host: \"localhost\"/server.host: \"0.0.0.0\"/" /etc/kibana/kibana.yml

systemctl restart kibana

ss -lnt | grep 5601