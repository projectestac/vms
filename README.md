# Vagrant VMS files for Projectes TAC

## Requirements

* You need to have [Vagrant] installed.
* The host machine probably needs at least 4 GB of RAM.
* As Oracle 11g XE is only available for 64-bit machines at the moment, the host machine needs to
  have a 64-bit architecture.
* You may need to [enable virtualization] manually.

## Installation

* Check out this project:

        git clone https://github.com/projectestac/vms.git

* Download the selected project from  https://github.com/projectestac/

* For agora project, Download [Oracle Database 11g Express Edition] for Linux x64. Place the file
  `oracle-xe-11.2.0-1.0.x86_64.rpm.zip` in the directory `provision` of this
  project.

* Enter to the folder of the selected project and run `vagrant up`. This should take a few minutes. Please
  note that building the VM involves downloading an Ubuntu 
  [base box](http://docs.vagrantup.com/v2/boxes.html) which is ~400MB in size.

## Vagrant instructions

* You can enter into the VM using: vagrant ssh

* To stop the VM: vagrant halt

* To restart the VM: vagrant reload

* To completely delete the VM: vagrant destroy

All commands must be executed from the project folder.

[Vagrant]: http://www.vagrantup.com/

[Oracle Database 11g Express Edition]: http://www.oracle.com/technetwork/database/database-technologies/express-edition/downloads/index.html

[Oracle Database 11g EE Documentation]: http://docs.oracle.com/cd/E17781_01/index.htm

[Installing Oracle 11g R2 Express Edition on Ubuntu 64-bit]: http://meandmyubuntulinux.blogspot.co.uk/2012/05/installing-oracle-11g-r2-express.html

[vagrant-oracle-xe]: https://github.com/codescape/vagrant-oracle-xe

[vbguest]: https://github.com/dotless-de/vagrant-vbguest

[enable virtualization]: http://www.sysprobs.com/disable-enable-virtualization-technology-bios
