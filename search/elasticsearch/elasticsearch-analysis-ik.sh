
cd /usr/local/src/
wget https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v1.9.4/elasticsearch-analysis-ik-1.9.4.zip
cd /usr/share/elasticsearch/plugins
#mkdir elasticsearch-analysis-ik-1.9.4
mkdir ik
cd ik
unzip /usr/local/src/elasticsearch-analysis-ik-1.9.4.zip

/etc/init.d/elasticsearch restart

#cat >> /etc/elasticsearch/elasticsearch.yml <<EOF
#EOF
#systemctl restart elasticsearch.service