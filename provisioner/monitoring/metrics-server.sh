#!/bin/bash
set -e

export KUBECONFIG=/etc/kubernetes/admin.conf
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

echo -e "finished metrics..."