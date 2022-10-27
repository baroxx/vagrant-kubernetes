#!/bin/bash
set -e

apt-get install -y containerd

mkdir /etc/containerd
containerd config default > /etc/containerd/config.toml
systemctl restart containerd

echo -e "finished..."