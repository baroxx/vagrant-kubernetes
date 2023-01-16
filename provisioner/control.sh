#!/bin/bash
set -e

readonly USER_NAME=$1
readonly KUBERNETES_VERSION=$2

IP=$(ip addr show enp0s3 | grep -o "inet [0-9]*\.[0-9]*\.[0-9]*\.[0-9]*" | grep -o "[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*") 
echo "$IP cp" >> /etc/hosts

echo -e "apiVersion: kubeadm.k8s.io/v1beta3
kind: ClusterConfiguration
kubernetesVersion: $KUBERNETES_VERSION
controlPlaneEndpoint: \"cp:6443\"
networking:
  podSubnet: 192.168.0.0/16" >> /home/$USER_NAME/kubeadm-config.yaml

kubeadm init --config=/home/$USER_NAME/kubeadm-config.yaml --upload-certs | tee kubeadm-init.out

mkdir /home/$USER_NAME/.kube
cp -i /etc/kubernetes/admin.conf /home/$USER_NAME/.kube/config

echo -e "finished..."