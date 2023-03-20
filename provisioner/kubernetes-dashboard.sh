#!/bin/bash
set -e

readonly KUBERNETES_DASHBOARD_VERSION=$1
readonly PROVISIONERS_PATH="/vagrant/provisioner"
readonly MANIFESTS_PATH="$PROVISIONERS_PATH/manifests/kubernetes-dashboard"
readonly TMP_ADMIN_TOKEN="$PROVISIONERS_PATH/tmp/admin-token.txt"

export KUBECONFIG=/etc/kubernetes/admin.conf
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v$KUBERNETES_DASHBOARD_VERSION/aio/deploy/recommended.yaml
kubectl apply -f $MANIFESTS_PATH
kubectl -n kubernetes-dashboard create token admin-user >> $TMP_ADMIN_TOKEN

echo -e "finished kubernetes-dashboard..."