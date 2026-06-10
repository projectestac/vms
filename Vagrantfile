Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/trusty64" # 14.04
  config.vm.provision :shell, inline: "hostnamectl set-hostname prestatgeria"

  config.vm.provision :hosts do |provisioner|
    provisioner.add_host '127.0.0.1', ["prestatgeria.xtec.cat"]
  end

  config.vm.network "private_network", ip: "192.168.56.11"

  config.vm.synced_folder "../prestatgeria", "/git/prestatgeria"
  config.vm.synced_folder "../prestatgeria/html", "/dades/prestatgeria/html"
  config.vm.synced_folder ".", "/vms", mount_options: ["dmode=775,fmode=775"]

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id,
                  "--name", "Prestatgeria - PHP 5.6",
                  "--cpus", "4",
                  "--memory", "2000",
                  "--natdnshostresolver1", "on",
                  "--natdnsproxy1", "on"]
  end

  config.vm.provision :shell, path: "provision.sh"

end
