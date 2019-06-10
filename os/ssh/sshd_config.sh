#!/bin/bash

cp /etc/ssh/sshd_config{,.original}
vim /etc/ssh/sshd_config <<EOF > /dev/null 2>&1
:37,37s/#LoginGraceTime 2m/LoginGraceTime 1m/
:40,40s/#MaxAuthTries 6/MaxAuthTries 3/
:79,79s/GSSAPIAuthentication yes/GSSAPIAuthentication no/
:99,99s/#AllowTcpForwarding yes/AllowTcpForwarding no/
:113,113s/#ClientAliveCountMax 3/ClientAliveCountMax 30/
:115,115s/#UseDNS yes/UseDNS no/
:wq
EOF

#:48,48s/#PermitRootLogin yes/PermitRootLogin no/

systemctl restart sshd

# ClientAliveCountMax 超时推出时间
