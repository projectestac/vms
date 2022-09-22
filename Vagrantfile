
Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/focal64"

  config.vm.provision :shell, inline: "hostnamectl set-hostname alexandria"

  config.vm.boot_timeout = 500

  config.vm.provision :hosts do |provisioner|
    provisioner.add_host '127.0.0.1', ["alexandria-aws.xtec.cat"]
  end

  config.vm.network "private_network", ip: "192.168.33.6"

  config.vm.synced_folder "../alexandria", "/git/alexandria"
  config.vm.synced_folder "../alexandria/html", "/dades/html"
  config.vm.synced_folder ".", "/vms", mount_options: ["dmode=775,fmode=775"]

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id,
                  "--name", "alexandria",
                  "--memory", "1000",
                  "--natdnshostresolver1", "on",
                  "--natdnsproxy1", "on"]
  end

  config.vm.provision :shell, path: "provision.sh"

end
