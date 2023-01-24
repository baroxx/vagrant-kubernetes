#!/bin/bash
set -e

readonly USER_NAME=$1
readonly KUBERNETES_VERSION="$2-00"

apt-get install -y kubeadm=$KUBERNETES_VERSION kubelet=$KUBERNETES_VERSION kubectl=$KUBERNETES_VERSION
apt-mark hold kubelet kubeadm kubectl
systemctl enable --now kubelet

apt-get install bash-completion -y
echo "source <(kubectl completion bash)" >> /home/$USER_NAME/.bashrc

echo -e "finished kubernetes..."