dnf -y upgrade
dnf -y install epel-release

dnf install -y lrzsz

cat >> /etc/profile.d/history.sh <<EOF
# Administrator specific aliases and functions for system security
export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "
export TIME_STYLE=long-iso
EOF

source /etc/profile.d/history.sh

dnf install -y maven-openjdk25

dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
dnf install -y docker-ce docker-compose-plugin
GID=$(egrep -o 'docker:x:([0-9]+)' /etc/group | egrep -o '([0-9]+)')
adduser --system -u ${GID} -g ${GID} -G wheel -c "Container Administrator" docker

systemctl enable docker
systemctl start docker

dnf install -y python3.13 python3.13-pip
/usr/bin/python3.13 -m venv /srv/python
source /srv/python/bin/activate
pip install --upgrade pip
pip install netkiller-devops