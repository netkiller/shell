#!/bin/bash

cp /etc/sudoers{,.original}

#vim /etc/sudoers <<EOF > /dev/null 2>&1
#visudo <<EOF > /dev/null 2>&1
#:118,118s:#includedir /etc/sudoers.d:includedir /etc/sudoers.d:
#:wq
#EOF