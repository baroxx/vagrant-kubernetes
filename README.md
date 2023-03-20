# Kubernetes on Ubuntu 20.04 with Vagrant

This project provides a basic setup of a Kubernetes nodes with Vagrant.

# Prerequisits

- Vagrant
- VirtualBox

# Configuration

You can change these properties in [Vagrantfile](Vagrantfile):

- CPUS = 2
- MEMORY = "4096"
- USER_NAME = "ubuntu"
- PASSWORD = "ubuntu"
- KEYMAP = "de"
- KUBERNETES_VERSION="1.26.2"
- KUBERNETES_DASHBOARD_VERSION="2.7.0"
- CP_IP="192.168.50.10"
- POD_SUBNET_CIDR="192.168.0.0/16"
- NODE_IP_RANGE="192.168.50." # keep the last number empty
- NUMBER_OF_NODES = 1

# Container runtime

There are provisioners for CRI-O (crio) and containerd. CRI-O is used in the default setup. Choose **one** of the provisioners in [Vagrantfile](Vagrantfile) in the cp and node config. The container runtime must be the same for each node in the cluster.

# Create Cluster

The creation of the cluster is as simple as executing [run.sh](run.sh).

# Access Cluster

There are two ways to access the cluster: via kubectl or with the Kubernetes dashboard

## kubectl

You can find the configuration for kubectl in [provisioner/tmp/config](provisioner/tmp/config) after the provisioning the cluster is done.

## Kubernetes Dashboard

You can find the token for the Kubernetes Dashboard in [provisioner/tmp/admin-token.txt](provisioner/tmp/admin-token.txt) after the provisioning the cluster is done.

To generate a new token just run: `kubectl -n kubernetes-dashboard create token admin-user`

# Provider

This project is tested with VirtualBox. It should be possible to use the setup with other providers as well.