#!/bin/bash
set -e

readonly PROMETHEUS_OPERATOR_VERSION=$1

export KUBECONFIG=/etc/kubernetes/admin.conf
kubectl create -f https://github.com/prometheus-operator/prometheus-operator/releases/download/v$PROMETHEUS_OPERATOR_VERSION/bundle.yaml

echo -e "finished metrics..."