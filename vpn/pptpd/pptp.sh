#!/bin/bash

yum install -y pptp pptp-setup
systemctl enable pptpd

cp /etc/pptpd.conf{,.original}

pptpsetup --create vpn0 --server vpn.netkiller.cn \
--username neo --password netkiller --encrypt
