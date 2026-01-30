cp /etc/dnf/dnf.conf{,.original}
echo "fastestmirror=true" >> /etc/dnf/dnf.conf
dnf makecache

dnf install -y https://mirrors.aliyun.com/epel/epel-release-latest-10.noarch.rpm
sed -i 's|^#baseurl=https://download.example/pub|baseurl=https://mirrors.aliyun.com|' /etc/yum.repos.d/epel*
sed -i 's|^metalink|#metalink|' /etc/yum.repos.d/epel*

dnf -y upgrade
dnf -y install epel-release

dnf install -y lrzsz

dnf install -y bzip2 tree psmisc telnet wget rsync vim-enhanced net-tools bind-utils

cat >> /etc/profile.d/history.sh <<EOF
# Administrator specific aliases and functions for system security
export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "
export TIME_STYLE=long-iso
EOF

source /etc/profile.d/history.sh

dnf install java-25-openjdk maven-openjdk25

dnf install -y python3.13 python3.13-pip
rm -f /usr/bin/python3
ln -s /usr/bin/python3.13 /usr/bin/python3
pip install netkiller-devops

dnf -y install dnf-plugins-core
#dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
dnf config-manager --add-repo http://mirrors.cloud.aliyuncs.com/docker-ce/linux/centos/docker-ce.repo
sed -i 's|https://mirrors.aliyun.com|http://mirrors.cloud.aliyuncs.com|g' /etc/yum.repos.d/docker-ce.repo
dnf install -y docker-ce docker-compose-plugin

GID=$(egrep -o 'docker:x:([0-9]+)' /etc/group | egrep -o '([0-9]+)')
adduser --system -u ${GID} -g ${GID} -G wheel -c "Container Administrator" docker

cat > /etc/sudoers.d/docker <<-EOF
docker    ALL=(ALL)    NOPASSWD: ALL
EOF

cat << EOF > /etc/docker/daemon.json
{
  "dns": [
    "119.29.29.29",
    "114.114.114.114"
  ],
  "insecure-registries": [
    "docker.1ms.run"
  ],
  "registry-mirrors": [
    "https://docker.1ms.run",
    "https://docker.xuanyuan.me"
  ]
}
EOF

systemctl enable docker
systemctl start docker