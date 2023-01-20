#!/bin/bash
set -e
IFNAME=$1
ADDRESS="$(ip -4 addr show $IFNAME | grep "inet" | head -1 |awk '{print $2}' | cut -d/ -f1)"
sed -e "s/^.*${HOSTNAME}.*/${ADDRESS} ${HOSTNAME} ${HOSTNAME}.local/" -i /etc/hosts


# Update /etc/hosts about other hosts
cat >> /etc/hosts <<EOF
192.168.56.2  control-plane
192.168.56.3  worker-node-01
192.168.56.4  worker-node-02
EOF
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo sysctl --system
echo 'export PS1="${cyan}\h ${red}$ ${clear_attributes}"' >> /root/.bash_profile
echo 'export PS1="${cyan}\h ${red}$ ${clear_attributes}"' >> /home/vagrant/.bash_profile
