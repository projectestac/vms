
Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/jammy64"

  config.vm.provision :shell, inline: "hostnamectl set-hostname agora"

  config.vm.provision :hosts do |provisioner|
    provisioner.add_host '127.0.0.1', ["agora-aws.xtec.cat"]
  end

  config.vm.network "private_network", ip: "192.168.33.5"

#  config.vm.network "forwarded_port", guest: 3306, host: 3306
#  config.vm.network "forwarded_port", guest: 5432, host: 5432
#  config.vm.network "forwarded_port", guest: 9003, host: 9003

  config.vm.synced_folder "../agora", "/git/agora"
  config.vm.synced_folder "../agora/html", "/dades/html"
  config.vm.synced_folder ".", "/vms", mount_options: ["dmode=775,fmode=775"]

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id,
                  "--name", "agora",
                  "--memory", "1000",
                  "--natdnshostresolver1", "on",
                  "--natdnsproxy1", "on"]
  end

  # config.disksize.size = '15GB'

  config.vm.provision :shell, path: "provision.sh"

end
