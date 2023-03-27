BASE_BOX = "ubuntu/focal64"
BOX_VERSION = "20230110.0.0"
CPUS = 2
MEMORY = "4096"
USER_NAME = "ubuntu"
PASSWORD = "ubuntu"
KEYMAP = "de"

CP_HOSTNAME="k8s-cp"
KUBERNETES_VERSION="1.26.2"
KUBERNETES_DASHBOARD_VERSION="2.7.0"
CP_IP="192.168.56.10"
POD_SUBNET_CIDR="192.168.0.0/16"
NODE_IP_RANGE="192.168.56." # keep the last number empty
NUMBER_OF_NODES = 1

Vagrant.configure("2") do |config|

    config.vm.define "k8s-cp" do |cp|
        cp.vm.box = BASE_BOX
        cp.vm.box_version = BOX_VERSION

        cp.vm.provider "virtualbox" do |virtualbox|
            virtualbox.name = CP_HOSTNAME
            virtualbox.cpus = CPUS
            virtualbox.memory = MEMORY
        end

        cp.vm.network "private_network", ip: CP_IP
        cp.vm.hostname = CP_HOSTNAME

        cp.vm.provision "main", type: "shell", args: [USER_NAME, PASSWORD, KEYMAP], path: "provisioner/main.sh"
        # Container runtime
        cp.vm.provision "crio", type: "shell", path: "provisioner/crio.sh"
        #cp.vm.provision "containerd", type: "shell", path: "provisioner/containerd.sh"
        cp.vm.provision "kubernetes", type: "shell", args: [USER_NAME, KUBERNETES_VERSION], path: "provisioner/kubernetes.sh"
        cp.vm.provision "control", type: "shell", args: [CP_HOSTNAME, CP_IP, CP_IP, POD_SUBNET_CIDR, USER_NAME, KUBERNETES_VERSION], path: "provisioner/control.sh"
        # CNI
        cp.vm.provision "calico", type: "shell", path: "provisioner/calico.sh"
        # Dashboards
        cp.vm.provision "kubernetes-dashboard", type: "shell", args: [KUBERNETES_DASHBOARD_VERSION], path: "provisioner/kubernetes-dashboard.sh"
        cp.vm.provision "final", type: "shell", args: [USER_NAME], path: "provisioner/final.sh"
    end

    (1..NUMBER_OF_NODES).each do |i|
        config.vm.define "node-#{i}" do |node|
            node.vm.box = BASE_BOX
            node.vm.box_version = BOX_VERSION

            node.vm.provider "virtualbox" do |vbnodes|
                vbnodes.name = "k8s-node-#{i}"
                vbnodes.cpus = CPUS
                vbnodes.memory = MEMORY
            end

            node.vm.network "private_network", ip: NODE_IP_RANGE+"#{i + 10}"
            node.vm.hostname = "node-#{i}"

            node.vm.provision "main", type: "shell", args: [USER_NAME, PASSWORD, KEYMAP], path: "provisioner/main.sh"
            # Container runtime
            node.vm.provision "crio", type: "shell", path: "provisioner/crio.sh"
            #node.vm.provision "containerd", type: "shell", path: "provisioner/containerd.sh"
            node.vm.provision "kubernetes", type: "shell", args: [USER_NAME, KUBERNETES_VERSION], path: "provisioner/kubernetes.sh"
            node.vm.provision "worker", type: "shell", args: [CP_HOSTNAME, CP_IP, NODE_IP_RANGE+"#{i + 10}"], path: "provisioner/worker.sh"
            node.vm.provision "final", type: "shell", args: [USER_NAME], path: "provisioner/final.sh"
        end
    end

end
  