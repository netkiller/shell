URL=https://github.com/oscm/shell

# Check if opening the firewall is needed with: 
sudo systemctl status firewalld 
sudo firewall-cmd --permanent --add-service=http 
sudo firewall-cmd --permanent --add-service=https 
sudo systemctl reload firewalld   

sudo dnf install postfix 
sudo systemctl enable postfix 
sudo systemctl start postfix


curl -s https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh | bash

EXTERNAL_URL="http://gitlab.example.com"

export LC_ALL=en_US.UTF-8  
export LANG=en_US.UTF-8
export LC_CTYPE=UTF-8

dnf install -y gitlab-ce

cp /etc/gitlab/gitlab.rb{,.original}

gitlab-ctl reconfigure

cat <<EOF
# Username: root 
# Password: 5iveL!fe
EOF
