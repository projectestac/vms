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

* For agora project, Download [Oracle Database 11g Express Edition] and [Oracle Instant Client] - Basic and Devel - for Linux x64.
  Place all downloaded files (`oracle-xe-11.2.0-1.0.x86_64.rpm.zip`, `oracle-instantclient12.1-basic-12.1.0.2.0-1.x86_64.rpm` and `oracle-instantclient12.1-devel-12.1.0.2.0-1.x86_64.rpm`)
  in the directory `provision/oracle` of this project.

* Please note that building the VM involves downloading an Ubuntu
  [base box](http://docs.vagrantup.com/v2/boxes.html) which is ~400MB in size.

## Vm Manages usage

In the root directory there is an script called vm. You may use this script to manage the VM's in order to get updates.
 * Usage: vm <project> [<action>]

 * Actions:

 * start: Starts the VM [default action]. This should take a few minutes.

 * ssh: Enters to the VM through ssh (starting if needed)

 * stop: Stops the VM

 * reboot: Reboots the VM

 * destroy: Completely destroys the VM. Asks for confirmation.

All commands must be executed from the main folder.


Oracle installation based in [vagrant-oracle-xe]

[Vagrant]: http://www.vagrantup.com/

[Oracle Database 11g Express Edition]: http://www.oracle.com/technetwork/database/database-technologies/express-edition/downloads/index.html

[Oracle Instant Client]: http://www.oracle.com/technetwork/topics/linuxx86-64soft-092277.html

[Oracle Database 11g EE Documentation]: http://docs.oracle.com/cd/E17781_01/index.htm

[vagrant-oracle-xe]: https://github.com/codescape/vagrant-oracle-xe

[vbguest]: https://github.com/dotless-de/vagrant-vbguest

[enable virtualization]: http://www.sysprobs.com/disable-enable-virtualization-technology-bios
