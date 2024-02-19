
Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/jammy64"

  config.vm.provision :shell, inline: "hostnamectl set-hostname sinapsi"

  config.vm.provision :hosts do |provisioner|
    provisioner.add_host '127.0.0.1', ["sinapsi-aws.xtec.cat"]
  end

  config.vm.network "private_network", ip: "192.168.56.8"

  config.vm.synced_folder "../sinapsi", "/dades/html"
  config.vm.synced_folder ".", "/vms", mount_options: ["dmode=775,fmode=775"]

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id,
                  "--name", "sinapsi",
                  "--cpus", "2",
                  "--memory", "800",
                  "--natdnshostresolver1", "on",
                  "--natdnsproxy1", "on"]
  end

  config.vm.provision :shell, path: "provision.sh"

end
