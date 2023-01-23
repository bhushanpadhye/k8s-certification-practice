#!/bin/bash

DOCKER_CE_VERSION=$1


# Install the yum-utils package (which provides the yum-config-manager utility) and set up the repository.
sudo yum install -y yum-utils
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

INSTALLSCR='sudo yum install -y docker-ce-"$DOCKER_CE_VERSION" \
 docker-ce-cli-"$DOCKER_CE_VERSION" \
 containerd.io \
 docker-compose-plugin'
eval 'echo "$INSTALLSCR"'
eval $INSTALLSCR

###Install Git
sudo yum install -y git


###Clone cri-dockerd source
cd /tmp
git clone https://github.com/Mirantis/cri-dockerd.git


###Install GO###
curl -O https://storage.googleapis.com/golang/getgo/installer_linux
chmod +x ./installer_linux
./installer_linux
source ~/.bash_profile

cd cri-dockerd
mkdir bin
go build -o bin/cri-dockerd
sudo mkdir -p /usr/local/bin
sudo install -o root -g root -m 0755 bin/cri-dockerd /usr/local/bin/cri-dockerd
sudo cp -a packaging/systemd/* /etc/systemd/system
sudo sed -i -e 's,/usr/bin/cri-dockerd,/usr/local/bin/cri-dockerd,' /etc/systemd/system/cri-docker.service
sudo systemctl daemon-reload
sudo systemctl enable cri-docker.service
sudo systemctl enable --now cri-docker.socket

# Start Docker
sudo systemctl enable docker
sudo systemctl enable --now docker
sudo systemctl start docker


