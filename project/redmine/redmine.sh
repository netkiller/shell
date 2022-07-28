curl -s https://raw.githubusercontent.com/netkiller/shell/master/database/mysql/mysql.server.sh | bash
curl -s https://raw.githubusercontent.com/netkiller/shell/master/database/mysql/mysql.devel.sh | bash

dnf install -y ruby rubygems ruby-devel ImageMagick-devel

groupadd -g 200 redmine
adduser --uid 200 --gid 200 -c "Redmine Application" redmine

cd /usr/local/src/
wget http://www.redmine.org/releases/redmine-3.3.1.tar.gz
tar zxf redmine-3.3.1.tar.gz
mv redmine-3.3.1 /srv/
ln -s /srv/redmine-3.3.1 /srv/redmine

chown redmine:redmine -R /srv/redmine*
su - redmine

cd /srv/redmine

#CREATE DATABASE redmine CHARACTER SET utf8;
#GRANT ALL PRIVILEGES ON redmine.* TO 'redmine'@'localhost' IDENTIFIED BY 'my_password';

cat >> config/database.yml <<EOF
production:
  adapter: mysql2
  database: redmine
  host: localhost
  username: redmine
  password: my_password
  encoding: utf8
EOF


#cp /srv/redmine/config/configuration.yml.example /srv/redmine/config/configuration.yml

gem install bundler
bundle install --without development test
bundle exec rake generate_secret_token

RAILS_ENV=production bundle exec rake db:migrate
#bundle exec rake redmine:load_default_data
RAILS_ENV=production REDMINE_LANG=zh bundle exec rake redmine:load_default_data

mkdir -p tmp tmp/pdf public/plugin_assets
chown -R redmine:redmine files log tmp public/plugin_assets
chmod -R 755 files log tmp public/plugin_assets

bundle exec rails server webrick -e production

#login: admin
#password: admin
