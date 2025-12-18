Vagrant.configure(2) do |config|

  config.vm.box = "gbailey/al2023"
  config.vm.provision :shell, inline: "hostnamectl set-hostname agora"
  config.vm.provision :hosts do |provisioner|
    provisioner.add_host '127.0.0.1', ["agora-aws.xtec.cat"]
  end

  config.vm.network "private_network", ip: "192.168.56.5"

  config.vm.synced_folder "../agora", "/git/agora"
  config.vm.synced_folder "../agora/html", "/dades/html", mount_options: ["dmode=777", "fmode=766"]
  config.vm.synced_folder ".", "/vms"

#  config.vm.network "forwarded_port", guest: 3306, host: 3306
#  config.vm.network "forwarded_port", guest: 5432, host: 5432
#  config.vm.network "forwarded_port", guest: 9003, host: 9003

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id,
                  "--name", "agora-awslinux2023-php83",
                  "--cpus", "4",
                  "--memory", "2000",
                  "--natdnshostresolver1", "on",
                  "--natdnsproxy1", "on"]
  end

  # config.disksize.size = '15GB'

  config.vm.provision :shell, path: "provision.sh"

end
