#!/bin/bash
set -e

readonly USER_NAME=$1
readonly PASSWORD=$2
readonly KEYMAP=$3    

echo $USER_NAME:$PASSWORD | sudo chpasswd
usermod -aG sudo $USER_NAME

timedatectl set-timezone Europe/Berlin
localectl set-x11-keymap $KEYMAP

apt-get install -y curl apt-transport-https git wget software-properties-common ca-certificates bash-completion

echo "source <(kubectl completion bash)" >> /home/$USER_NAME/.bashrc

swapoff -a
sed -i '/swap/d' /etc/fstab

cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF
modprobe overlay
modprobe br_netfilter
cat << EOF | tee /etc/sysctl.d/kubernetes.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF
sysctl --system

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

echo -e "deb  http://apt.kubernetes.io/  kubernetes-xenial  main" >> /etc/apt/sources.list.d/kubernetes.list
apt-get update

echo -e "finished main..."