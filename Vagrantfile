BOX = "ubuntu/focal64"
BOX_VERSION = "20230110.0.0"
HOSTNAME = "ubuntu"
CPUS = 2
MEMORY = "4096"
USER_NAME = "ubuntu"
PASSWORD = "ubuntu"
KEYMAP = "de"

KUBERNETES_VERSION="1.24.4"

# worker config
CP_IP="192.168.56."
JOIN_TOKEN=""
DISCOVERY_HASH="sha256:"

Vagrant.configure("2") do |config|
    config.vm.box = BOX
    config.vm.box_version = BOX_VERSION
  
    config.vm.hostname = HOSTNAME

    config.vm.provider "virtualbox" do |vm|
        vm.cpus = CPUS
        vm.memory = MEMORY
    end

    config.vm.network "private_network", type: "dhcp"

    config.vm.provision "main", type: "shell", args: [USER_NAME, PASSWORD, KEYMAP], run: "never", path: "provisioner/main.sh"

    # Container runtime
    config.vm.provision "crio", type: "shell", run: "never", path: "provisioner/crio.sh"
    config.vm.provision "containerd", type: "shell", run: "never", path: "provisioner/containerd.sh"

    config.vm.provision "kubernetes", type: "shell", args: [USER_NAME, KUBERNETES_VERSION], run: "never", path: "provisioner/kubernetes.sh"

    # Node type
    config.vm.provision "control", type: "shell", args: [USER_NAME, KUBERNETES_VERSION], run: "never", path: "provisioner/control.sh"
    config.vm.provision "worker", type: "shell", args: [CP_IP, JOIN_TOKEN, DISCOVERY_HASH], run: "never", path: "provisioner/worker.sh"

    # CNI
    config.vm.provision "calico", type: "shell", run: "never", path: "provisioner/calico.sh"

    config.vm.provision "final", type: "shell", args: [USER_NAME], run: "never", path: "provisioner/final.sh"
end
  