# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "candide-1.1"
  # config.vm.box_url = "http://domain.com/path/to/above.box"

  config.vm.network :private_network, ip: "192.168.33.10"

  config.vm.synced_folder "www/", "/var/www", nfs: true

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end

end
