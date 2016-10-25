#sed -i '66s/#//' /srv/redmine/config/configuration.yml
#sed -i '67s/#//' /srv/redmine/config/configuration.yml

cat > /srv/redmine/config/configuration.yml <<EOF
production:
  email_delivery:
    delivery_method: :smtp
    smtp_settings:
      address: 104.243.134.186
      port: 25
      domain: :none
      autentication: :none
      user_name: noreply@netkiller.cn
EOF