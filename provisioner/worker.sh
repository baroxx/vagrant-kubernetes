#!/bin/bash
set -e

readonly CP_IP=$1
readonly NODE_IP=$2

echo "KUBELET_EXTRA_ARGS=--node-ip=$NODE_IP" >> /etc/default/kubelet
systemctl restart kubelet
echo "$CP_IP cp" >> /etc/hosts
/vagrant/provisioner/tmp/join.sh

echo -e "finished worker..."