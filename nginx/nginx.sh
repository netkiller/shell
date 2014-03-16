#!/bin/bash

sudo apt-get install nginx

sudo cp /etc/nginx/nginx.conf{,.original}

sudo vim /etc/nginx/nginx.conf <<VIM > /dev/null 2>&1
:21,21s/# server_tokens off;/server_tokens on;/
:wq
VIM
