#!/bin/bash

sed -i 's/# requirepass foobared/requirepass passw0rd/g' /etc/redis.conf 

