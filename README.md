# Kubernetes on Ubuntu 20.04 with Vagrant

This project provides a basic setup of a Kubernetes node with Vagrant. You can clone this repository multipe times to configure a controle plane with worker nodes.

# General configuration

You can change these properties:

- HOSTNAME = "ubuntu" <- must be unique in the cluster
- CPUS = 2
- MEMORY = "4096"
- USER_NAME = "ubuntu"
- PASSWORD = "ubuntu"
- KEYMAP = "de"

## Control Plane

1. Set KUBERNETES_VERSION in [Vagrantfile](Vagrantfile)
2. Adjust [create_cp.sh](create_cp.sh)
3. Run [create_cp.sh](create_cp.sh)

## Worker Node

1. Set properties KUBERNETES_VERSION, CP_IP and JOIN_TOKEN in [Vagrantfile](Vagrantfile) (you can get the control plane IP, the join token, the discovery hash and the cert hash from the control plane)
2. Adjust [create_worker.sh](create_wn.sh)
3. Run [create_worker.sh](create_wn.sh)

# Provider

This project is tested with libvirt. It should be possible to use the setup with VirtualBox as well. Change the provider config to something like that:

```
    config.vm.provider "virtualbox" do |vm|
        vm.cpus = CPUS
        vm.memory = MEMORY
        vm.keymap = KEYMAP
    end
```