vim /etc/ssh/sshd_config <<EOF > /dev/null 2>&1
:92,92s/#GSSAPIAuthentication no/GSSAPIAuthentication no/
:93,93s/GSSAPIAuthentication yes/#GSSAPIAuthentication yes/
:130,130s/#UseDNS yes/UseDNS no/
:wq
EOF
