#!/bin/bash

cp /etc/ssh/sshd_config{,.original}

vim /etc/ssh/sshd_config <<EOF > /dev/null 2>&1
:43,43s/PermitRootLogin yes/PermitRootLogin no/
:84,84s/GSSAPIAuthentication yes/GSSAPIAuthentication no/
:99,99s/#AllowTcpForwarding yes/AllowTcpForwarding no/
:106,106/X11Forwarding yes/X11Forwarding no/
:116,116s/#TCPKeepAlive yes/TCPKeepAlive yes/
:121,121s/#UseDNS no/UseDNS no/
:wq
EOF

#:42,42s/#LoginGraceTime 2m/LoginGraceTime 1m/
#:40,40s/#MaxAuthTries 6/MaxAuthTries 3/
#:112,112s/#ClientAliveInterval 0/ClientAliveInterval 30/
#:113,113s/#ClientAliveCountMax 3/ClientAliveCountMax 9/

systemctl restart sshd

# ClientAliveCountMax 超时推出时间
