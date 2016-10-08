#sed -i '66s/#//' /srv/redmine/config/configuration.yml
#sed -i '67s/#//' /srv/redmine/config/configuration.yml

cat > /srv/redmine/config/configuration.yml <<EOF
production:
  email_delivery:
    delivery_method: :stmp
    smtp_settings:
      address: localhost
      port: 25
      domain: cf139.com
      user_name: redmine@example.com
EOF