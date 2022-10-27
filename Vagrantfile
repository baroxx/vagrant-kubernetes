BOX = "generic/ubuntu2004"
BOX_VERSION = "4.1.18"
HOSTNAME = "ubuntu"
CPUS = 2
MEMORY = "4096"
USER_NAME = "ubuntu"
PASSWORD = "ubuntu"
KEYMAP = "de"

KUBERNETES_VERSION="1.24.4"

# worker config
CP_IP="192.168.122."
JOIN_TOKEN=""
DISCOVERY_HASH="sha256:"
CERT_HASH=""

Vagrant.configure("2") do |config|
    config.vm.box = BOX
    config.vm.box_version = BOX_VERSION
  
    config.vm.hostname = HOSTNAME
  
    config.vm.provider "libvirt" do |vm|
        vm.cpus = CPUS
        vm.memory = MEMORY
        vm.keymap = KEYMAP
        vm.graphics_type = "spice"
        vm.video_type = "virtio"
        vm.cpu_mode = "host-passthrough"
        vm.channel :type => 'spicevmc', :target_name => 'com.redhat.spice.0', :target_type => 'virtio'
    end

    config.vm.provision "main", type: "shell", args: [USER_NAME, PASSWORD, KEYMAP], run: "never", path: "provisioner/main.sh"

    config.vm.provision "containerd", type: "shell", run: "never", path: "provisioner/containerd.sh"

    config.vm.provision "kubernetes", type: "shell", args: [USER_NAME, KUBERNETES_VERSION], run: "never", path: "provisioner/kubernetes.sh"

    config.vm.provision "control", type: "shell", args: [USER_NAME, KUBERNETES_VERSION], run: "never", path: "provisioner/control.sh"

    config.vm.provision "worker", type: "shell", args: [CP_IP, JOIN_TOKEN, DISCOVERY_HASH, CERT_HASH], run: "never", path: "provisioner/worker.sh"

    config.vm.provision "calico", type: "shell", run: "never", path: "provisioner/calico.sh"

    config.vm.provision "final", type: "shell", args: [USER_NAME], run: "never", path: "provisioner/final.sh"
end
  