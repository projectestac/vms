
Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/bionic64"

  config.vm.provision :shell, inline: "hostnamectl set-hostname alexandria"

  config.vm.provision :hosts do |provisioner|
    provisioner.add_host '127.0.0.1', ["alexandria-aws.xtec.cat"]
  end

  config.vm.network "private_network", ip: "192.168.33.6"

  config.vm.synced_folder "../alexandria", "/git/alexandria"
  config.vm.synced_folder "../alexandria/html", "/dades/html"
  #config.vm.synced_folder "../moodlemobile2", "/dades/moodlemobile2"
  config.vm.synced_folder ".", "/vms", mount_options: ["dmode=775,fmode=775"]

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id,
                  "--name", "alexandria",
                  "--memory", "1000",
                  "--natdnshostresolver1", "on",
                  "--natdnsproxy1", "on"]
  end

  #config.push.define "atlas" do |push|
  #  push.app = "projectestac/agora"
  #end

  config.vm.provision :shell, path: "provision.sh"

end
