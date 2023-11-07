
Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/jammy64"
  config.vm.provision :shell, inline: "hostnamectl set-hostname agora"
  config.vm.boot_timeout = 500

  config.vm.provision :hosts do |provisioner|
    provisioner.add_host '127.0.0.1', ["odissea-aws.xtec.cat"]
  end

  config.vm.network "private_network", ip: "192.168.56.7"

  config.vm.synced_folder "../odissea", "/git/odissea"
  config.vm.synced_folder "../odissea/html", "/dades/html"
  config.vm.synced_folder ".", "/vms", mount_options: ["dmode=775,fmode=775"]

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id,
                  "--name", "odissea",
                  "--memory", "1000",
                  "--natdnshostresolver1", "on",
                  "--natdnsproxy1", "on"]
  end

  config.vm.provision :shell, path: "provision.sh"

end
