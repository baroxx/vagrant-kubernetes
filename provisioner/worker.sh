#!/bin/bash
set -e

readonly CP_IP=$1
readonly JOIN_TOKEN=$2
readonly DISCOVERY_HASH=$3
readonly CERT_HASH=$4

echo "$CP_IP cp" >> /etc/hosts

kubeadm join cp:6443 --token $JOIN_TOKEN --discovery-token-ca-cert-hash $DISCOVERY_HASH --control-plane --certificate-key $CERT_HASH

echo -e "finished..."