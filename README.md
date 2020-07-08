# Vagrant VMS files for Projectes TAC

## Requirements


* You need to have [Vagrant](https://www.vagrantup.com/downloads.html) and the official [VirtualBox](https://www.virtualbox.org/wiki/Downloads) installed.
* [vagrant-hosts] vagrant plugin. It will be installed the first time you run vm script.

    `vagrant plugin install vagrant-hosts`
    
* The host machine probably needs at least 4 GB of RAM.
* You may need to [enable virtualization] manually.

## Installation

* Clone this project:

        git clone https://github.com/projectestac/vms.git

* Change to the AWS branch

        git checkout -b aws origin/aws

* Please note that building the VM involves downloading an Ubuntu
  [base box](https://www.vagrantup.com/docs/boxes.html) which is ~400MB in size.

## Vm Manages usage

In the vms directory there is an script called vm. You may use this script to manage the VM's in order to get updates:

`./vm`

This will start the VM getting and executing the latest updates. This should take a few minutes.

You may also want to use vagrant standard commands:

* **vagrant up** to start the VM.

* **vagrant ssh** to enter into the VM via ssh.

* **vagrant halt** to stop the VM.

* **vagrant reload** to restart the VM.

* **vagrant destroy** to completely delete the VM. Asks for confirmation.

## Hostnames and IP

You must add the following line to your /etc/hosts in order to get access to the VM:

    192.168.33.5 agora-aws.xtec.cat agora-aws-se.xtec.cat agora-aws-projectes.xtec.cat agora-aws-nodes.xtec.cat


[Vagrant]: http://www.vagrantup.com/

[VirtualBox]: https://www.virtualbox.org/

[vbguest]: https://github.com/dotless-de/vagrant-vbguest

[enable virtualization]: http://www.sysprobs.com/disable-enable-virtualization-technology-bios

[vagrant-hosts]: https://github.com/adrienthebo/vagrant-hosts
