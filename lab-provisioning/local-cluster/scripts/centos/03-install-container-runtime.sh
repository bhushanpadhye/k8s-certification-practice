#!/bin/bash

OSVERSION=$1
DOCKER_EE_VERSION=$2

# Uninstall existing docker if any
sudo yum remove docker \
                docker-client \
                docker-client-latest \
                docker-common \
                docker-latest \
                docker-latest-logrotate \
                docker-logrotate \
                docker-selinux \
                docker-engine-selinux \
                docker-engine\
                docker-ee\
                docker-ee-cli

# Remove existing Docker repositories from /etc/yum.repos.d/
sudo rm /etc/yum.repos.d/docker*.repo

#URL to mirantis repo
export DOCKERURL="https://repos.mirantis.com"


# Store the value of the variable, DOCKERURL (from the previous step), in a yum variable in /etc/yum/vars/
sudo -E sh -c 'echo "$DOCKERURL/centos" > /etc/yum/vars/dockerurl'

# Store your OS version string in /etc/yum/vars/dockerosversion
echo "$OSVERSION" >> /etc/yum/vars/dockerosversion

# Install the yum-utils that provides the yum-config-manager utility
sudo yum install -y yum-utils

# Enable the extras RHEL repository. This ensures access to the container-selinux package required by docker-ee. (Not for IBM)
sudo yum-config-manager --enable rhel-7-server-extras-rpms

# Add the Mirantis Container Runtime stable repository
sudo -E yum-config-manager \
    --add-repo \
    "$DOCKERURL/centos/docker-ee.repo"

# Install a specific version by its fully qualified package name
INSTALLSCR='sudo yum -y install docker-ee-"$DOCKER_EE_VERSION" \
docker-ee-cli-"$DOCKER_EE_VERSION" \
docker-ee-rootless-extras-"$DOCKER_EE_VERSION" containerd.io'
eval 'echo "$INSTALLSCR"'
eval $INSTALLSCR

# Start Docker
sudo systemctl start docker

sudo systemctl status cri-docker.socket | grep "Listen" | awk '{print $2}' 