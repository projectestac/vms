Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.provision :shell, inline: "hostnamectl set-hostname dossier"

  config.vm.provision :hosts do |provisioner|
    provisioner.add_host '127.0.0.1', ["dossier-virtual.xtec.cat"]
  end

  config.vm.network "private_network", ip: "192.168.56.24"

  config.vm.synced_folder "../dossier", "/git/dossier"
  config.vm.synced_folder "../dossier/html", "/dades/dossier/html"

  config.vm.synced_folder ".", "/vms", mount_options: ["dmode=775,fmode=775"]

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id,
                  "--name", "Dossier - PHP 7.0",
                  "--memory", "2048",
                  "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
  end
  config.vm.provision :shell, path: "provision.sh"
end
