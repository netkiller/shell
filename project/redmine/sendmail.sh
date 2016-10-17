#sed -i '66s/#//' /srv/redmine/config/configuration.yml
#sed -i '67s/#//' /srv/redmine/config/configuration.yml

cat > /srv/redmine/config/configuration.yml <<EOF
production:
  email_delivery:
    delivery_method: :sendmail
EOF

# Exam4
#production:
#  email_delivery:
#    delivery_method: :sendmail
#    sendmail_settings:
#      arguments: "-i"