#!/bin/bash
set -e
UNAME=$1
PWD=$2

echo $UNAME

mkdir /home/"$UNAME"
useradd "$UNAME" -s /bin/bash -d /home/"$UNAME"
echo "$UNAME:$PWD" | chpasswd
usermod -aG wheel "$UNAME"
chown "$UNAME" /home/"$UNAME"

swapoff -a

echo 'sudo -i' >> /home/vagrant/.bash_profile

sudo sed -i "/^[^#]*PasswordAuthentication[[:space:]]no/c\PasswordAuthentication yes" /etc/ssh/sshd_config
sudo service sshd restart