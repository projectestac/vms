
Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/bionic64"

  config.vm.provision :shell, inline: "hostnamectl set-hostname agora"

  config.vm.provision :hosts do |provisioner|
    provisioner.add_host '127.0.0.1', ["agora-aws.xtec.cat"]
  end

  config.vm.network "private_network", ip: "192.168.33.5"

  config.vm.synced_folder "../agora", "/git/agora"
  config.vm.synced_folder "../agora/html", "/dades/html"
  #config.vm.synced_folder "../moodlemobile2", "/dades/moodlemobile2"
  config.vm.synced_folder ".", "/vms", mount_options: ["dmode=775,fmode=775"]

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id,
                  "--name", "agora-only",
                  "--memory", "1000",
                  "--natdnshostresolver1", "on",
                  "--natdnsproxy1", "on"]
  end

  #config.push.define "atlas" do |push|
  #  push.app = "projectestac/agora"
  #end

  config.vm.provision :shell, path: "provision.sh"

end
