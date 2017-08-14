
cd /usr/local/src/
wget https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v5.2.2/elasticsearch-analysis-ik-5.2.2.zip
cd /usr/share/elasticsearch/plugins
rm -rf ik
mkdir ik
cd ik

unzip /usr/local/src/elasticsearch-analysis-ik-5.2.2.zip

chown -R elasticsearch:elasticsearch ../ik
#/etc/init.d/elasticsearch restart
systemctl restart elasticsearch.service

#cat >> /etc/elasticsearch/elasticsearch.yml <<EOF
#EOF
#systemctl restart elasticsearch.service