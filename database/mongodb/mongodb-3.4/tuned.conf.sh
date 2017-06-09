mkdir /etc/tuned/no-thp

# Enable the new profile.

cat << 'EOF' >> /etc/tuned/no-thp/tuned.conf
[main]
include=virtual-guest

[vm]
transparent_hugepages=never
EOF

# Finally, enable the new profile by issuing:

tuned-adm profile no-thp