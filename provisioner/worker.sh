#!/bin/bash
set -e

readonly CP_HOSTNAME=$1
readonly CP_IP=$2
readonly NODE_IP=$3

echo "KUBELET_EXTRA_ARGS=--node-ip=$NODE_IP" >> /etc/default/kubelet
systemctl restart kubelet
echo "$CP_IP $CP_HOSTNAME" >> /etc/hosts
/vagrant/provisioner/tmp/join.sh

echo -e "finished worker..."