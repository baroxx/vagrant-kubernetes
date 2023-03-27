#!/bin/bash
set -e

readonly CP_HOSTNAME=$1
readonly CP_IP=$2
readonly NODE_IP=$3
readonly POD_SUBNET_CIDR=$4
readonly USER_NAME=$5
readonly KUBERNETES_VERSION=$6
readonly TMP_DIR="/vagrant/provisioner/tmp"
readonly TMP_JOIN_SCRIPT="$TMP_DIR/join.sh"
readonly TMP_KUBE_CONFIG="$TMP_DIR/config"

echo "KUBELET_EXTRA_ARGS=--node-ip=$NODE_IP" >> /etc/default/kubelet
systemctl restart kubelet
echo "$CP_IP $CP_HOSTNAME" >> /etc/hosts

echo -e "apiVersion: kubeadm.k8s.io/v1beta3
kind: InitConfiguration
localAPIEndpoint:
  advertiseAddress: \"$NODE_IP\"
---
apiVersion: kubeadm.k8s.io/v1beta3
kind: ClusterConfiguration
kubernetesVersion: $KUBERNETES_VERSION
controlPlaneEndpoint: \"$CP_IP:6443\"
networking:
  podSubnet: $POD_SUBNET_CIDR" >> /home/$USER_NAME/kubeadm-config.yaml

kubeadm init --config=/home/$USER_NAME/kubeadm-config.yaml --upload-certs | tee kubeadm-init.out

mkdir /home/$USER_NAME/.kube
cp /etc/kubernetes/admin.conf /home/$USER_NAME/.kube/config
cp -f /etc/kubernetes/admin.conf $TMP_KUBE_CONFIG

rm -f $TMP_JOIN_SCRIPT
kubeadm token create --print-join-command >> $TMP_JOIN_SCRIPT
chmod u+x $TMP_JOIN_SCRIPT

echo -e "finished control..."