
Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/focal64"

  config.vm.provision :shell, inline: "hostnamectl set-hostname ioc"

  config.vm.provision :hosts do |provisioner|
    provisioner.add_host '127.0.0.1', ["ioc-aws.xtec.cat"]
  end

  config.vm.network "private_network", ip: "192.168.33.10"

  config.vm.synced_folder "../moodle", "/git/moodle"
  config.vm.synced_folder "../moodle", "/dades/html"
  config.vm.synced_folder ".", "/vms", mount_options: ["dmode=775,fmode=775"]

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id,
                  "--name", "ioc",
                  "--memory", "1000",
                  "--natdnshostresolver1", "on",
                  "--natdnsproxy1", "on"]
  end

  # config.disksize.size = '15GB'

  config.vm.provision :shell, path: "provision.sh"

end
