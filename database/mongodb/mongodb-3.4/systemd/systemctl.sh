#!/bin/bash

wget -q https://raw.githubusercontent.com/oscm/shell/master/database/mongodb/mongodb-3.4/systemd/disable-transparent-huge-pages.service -O /usr/lib/systemd/system/disable-transparent-huge-pages.service

systemctl enable disable-transparent-huge-pages
systemctl start disable-transparent-huge-pages
systemctl status disable-transparent-huge-pages
