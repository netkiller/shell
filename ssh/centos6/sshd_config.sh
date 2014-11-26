vim /etc/ssh/sshd_config <<EOF > /dev/null 2>&1
:80,80s/#GSSAPIAuthentication no/GSSAPIAuthentication no/
:122,122s$#UseDNS yes$UseDNS no$
:80,80s/#GSSAPIAuthentication no/GSSAPIAuthentication no/
:wq
EOF
