#!/bin/bash

dnf install -y gnokii	

chmod +x  /usr/bin/sendsms

cp /etc/gnokiirc{,.original}

mkdir -p ~/.cache/gnokii/

vim /etc/gnokiirc <<VIM > /dev/null 2>&1
:%s:port = none:port = /dev/ttyS0:
:54,54s/model = fake/model = AT/
:%s/debug = on/debug = off/
:wq
VIM

#:%s:#gnokiierrorpath=.:gnokiierrorpath=/var/tmp/gnokii-errors:
