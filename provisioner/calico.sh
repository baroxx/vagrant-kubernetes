#!/bin/bash
set -e

export KUBECONFIG=/etc/kubernetes/admin.conf

wget https://docs.projectcalico.org/manifests/calico.yaml -O calico.yaml
kubectl apply -f calico.yaml
rm calico.yaml

echo -e "finished calico..."