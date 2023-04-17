#!/bin/bash
set -e

readonly USER_NAME=$1
readonly TMP_DIR="/vagrant/provisioner/tmp"
readonly TMP_KUBE_CONFIG="$TMP_DIR/config"

apt-get update
apt-get -y upgrade
chown -R $USER_NAME:$USER_NAME /home/$USER_NAME

export KUBECONFIG=$TMP_KUBE_CONFIG
CSR_NAME=$(kubectl get csr -o=jsonpath='{.items[?(@.spec.request nin "")].metadata.name}')
kubectl certificate approve $CSR_NAME

echo -e "finished..."