dnf install -y ansible

if [ ! -f /usr/bin/git ]; then
	dnf install -y git
fi
cd /srv/
git clone https://github.com/oscm/ansible.git
