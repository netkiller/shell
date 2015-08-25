#!/bin/bash

pecl install solr

cat > /srv/php/etc/conf.d/solr.ini <<EOF
extension=solr.so
EOF
