#!/bin/bash
set -e

export KUBECONFIG=/etc/kubernetes/admin.conf

curl https://raw.githubusercontent.com/projectcalico/calico/v3.25.0/manifests/calico.yaml -O
kubectl apply -f calico.yaml
rm calico.yaml

echo -e "finished calico..."