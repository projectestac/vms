
Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/bionic64"

  config.vm.provision :shell, inline: "hostnamectl set-hostname sinapsi"

  config.vm.provision :hosts do |provisioner|
    provisioner.add_host '127.0.0.1', ["sinapsi-aws.xtec.cat"]
  end

  config.vm.network "private_network", ip: "192.168.33.8"

  config.vm.synced_folder "../sinapsi", "/git/sinapsi"
  #config.vm.synced_folder "../sinapsi/html", "/dades/src"
  config.vm.synced_folder ".", "/vms", mount_options: ["dmode=775,fmode=775"]

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id,
                  "--name", "sinapsi",
                  "--memory", "800",
                  "--natdnshostresolver1", "on",
                  "--natdnsproxy1", "on"]
  end

  config.vm.provision :shell, path: "provision.sh"

end
