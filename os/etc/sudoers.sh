#!/bin/bash

#================================================================================
sed -i "s/#PermitRootLogin yes/PermitRootLogin no/" /etc/ssh/sshd_config
systemctl restart sshd
#================================================================================

cp /etc/sudoers{,.original}

#vim /etc/sudoers <<EOF > /dev/null 2>&1
visudo <<EOF > /dev/null 2>&1
:120,120s:#includedir /etc/sudoers.d:includedir /etc/sudoers.d:
:wq
EOF

visudo -c

sed -i '88s#$#:/usr/local/sbin:/usr/local/bin#' /etc/sudoers


#cat > /etc/sudoers.d/secure_path.conf <<'EOF'
#Defaults    secure_path = /sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
#EOF