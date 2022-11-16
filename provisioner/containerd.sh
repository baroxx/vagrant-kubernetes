#!/bin/bash
set -e

apt-get install -y containerd

mkdir /etc/containerd
containerd config default > /etc/containerd/config.toml
systemctl restart containerd

crictl config --set runtime-endpoint=unix:///run/containerd/containerd.sock --set image-endpoint=unix:///run/containerd/containerd.sock

echo -e "finished..."