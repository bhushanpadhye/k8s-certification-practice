#!/bin/bash

DOCKER_CE_VERSION=$1

# Uninstall previous docker if present
sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine

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

sudo sed -i 's/disabled_plugins/#   disabled_plugins/g' /etc/containerd/config.toml
sudo systemctl restart containerd

# Start Docker
sudo systemctl start docker
