vim /etc/ssh/sshd_config <<EOF > /dev/null 2>&1
:80,80s/#GSSAPIAuthentication no/GSSAPIAuthentication no/
:81,81s/GSSAPIAuthentication yes/#GSSAPIAuthentication yes/
:122,122s$#UseDNS yes$UseDNS no$
:wq
EOF
