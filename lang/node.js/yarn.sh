curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/dnf.repos.d/yarn.repo

dnf install -y yarn