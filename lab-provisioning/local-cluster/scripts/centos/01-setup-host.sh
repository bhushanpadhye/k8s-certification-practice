#!/bin/bash
set -e
IFNAME=$1
IP_SERIES=$2
NUM_CONTROL_PLANE=$3
NUM_WORKER_NODES=$4
MASTER_IP_START=$5
NODE_IP_START=$6

ADDRESS="$(ip -4 addr show $IFNAME | grep "inet" | head -1 |awk '{print $2}' | cut -d/ -f1)"
sed -e "s/^.*${HOSTNAME}.*/${ADDRESS} ${HOSTNAME} ${HOSTNAME}.local/" -i /etc/hosts

for i in $(eval echo "{1..$NUM_CONTROL_PLANE}")
do
	echo "$IP_SERIES$(($MASTER_IP_START+$i)) control-plane-$i" >> /etc/hosts
done

for j in $(eval echo "{1..$NUM_WORKER_NODES}")
do
    echo "$IP_SERIES$(($NODE_IP_START+$j)) worker-node-$j" >> /etc/hosts
done