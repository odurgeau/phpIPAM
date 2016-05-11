# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "bento/debian-7.8"

  config.vm.network "forwarded_port", guest: 80, host: 1234

  config.vm.provision "shell", path: "install-phpipam.sh"

end
