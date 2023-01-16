# Kubernetes on Ubuntu 20.04 with Vagrant

This project provides a basic setup of a Kubernetes node with Vagrant. Each virtual machine needs its own directory for Vagrant. You can clone this repository multipe times to configure a controle plane with worker nodes. Vagrant creates for each virtual machine a .vagrant directory. **Delete the .vagrant directory after copying an existing Vagrant setup.**

# Prerequisits

- Vagrant
- VirtualBox

# Configuration

You can change these properties:

- HOSTNAME = "ubuntu" <- must be unique in the cluster
- CPUS = 2
- MEMORY = "4096"
- USER_NAME = "ubuntu"
- PASSWORD = "ubuntu"
- KEYMAP = "de"

## Container runtime

There are provisioners for CRI-O (crio) and containerd. Choose **one** in [create_cp.sh](create_cp.sh) and [create_worker.sh](create_wn.sh).

## Control Plane

1. Set KUBERNETES_VERSION in [Vagrantfile](Vagrantfile)
2. Adjust [create_cp.sh](create_cp.sh)
3. Run [create_cp.sh](create_cp.sh)

## Worker Node

1. Set properties KUBERNETES_VERSION, CP_IP and JOIN_TOKEN in [Vagrantfile](Vagrantfile) (you can get the control plane IP, the join token and the discovery hash from the control plane)
2. Adjust [create_worker.sh](create_wn.sh)
3. Run [create_worker.sh](create_wn.sh)

# Provider

This project is tested with VirtualBox. It should be possible to use the setup with VirtualBox as well. Change the provider config to something like that:

```
    config.vm.provider "virtualbox" do |vm|
        vm.cpus = CPUS
        vm.memory = MEMORY
    end
```