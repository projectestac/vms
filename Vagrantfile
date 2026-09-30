Vagrant.configure(2) do |config|

  config.vm.box = "gbailey/al2023"
  config.vm.provision :shell, inline: "hostnamectl set-hostname xtecblocs"
  config.vm.provision :hosts do |provisioner|
    provisioner.add_host '127.0.0.1', ["blocs-aws.xtec.cat"]
  end

  config.vm.network "private_network", ip: "192.168.56.23"

  config.vm.synced_folder "../xtecblocs", "/git/xtecblocs"
  config.vm.synced_folder "../xtecblocs/html", "/dades/blocs/html", mount_options: ["dmode=777", "fmode=666"]
  config.vm.synced_folder ".", "/vms"

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id,
                  "--name", "XTECBlocs 7 - PHP 8.5",
                  "--cpus", "4",
                  "--memory", "2000",
                  "--natdnshostresolver1", "on",
                  "--natdnsproxy1", "on"]
  end

  config.vm.provision :shell, path: "provision.sh"
end
