Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.provision :shell, inline: "hostnamectl set-hostname xtecblocs"

  config.vm.provision :hosts do |provisioner|
    provisioner.add_host '127.0.0.1', ["blocs-aws.xtec.cat"]
  end

  config.vm.network "private_network", ip: "100.64.56.23"

  config.vm.synced_folder "../xtecblocs-sic", "/git/xtecblocs"
  config.vm.synced_folder "../xtecblocs-sic", "/dades/blocs/src"

  config.vm.synced_folder ".", "/vms", mount_options: ["dmode=775,fmode=775"]

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id,
                  "--name", "XTECBlocs - PHP 7.4",
                  "--memory", "2048",
                  "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
  end
  config.vm.provision :shell, path: "provision.sh"
end
