# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  config.vm.hostname = "candide-berkshelf"

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "candide-1.0"
  #config.vm.box = "opscode-centos-6.4"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "https://s3-us-west-2.amazonaws.com/btm-candide/candide-1.0.pkg"
  #config.vm.box_url = "https://opscode-vm-bento.s3.amazonaws.com/vagrant/opscode_centos-6.4_provisionerless.box"

  # Installs the latest version of chef-client.
  config.omnibus.chef_version = :latest

  # Assign this VM to a host-only network IP, allowing you to access it
  # via the IP. Host-only networks can talk to the host machine as well as
  # any other machines on the same network, but cannot be accessed (through this
  # network interface) by any external networks.
  config.vm.network :private_network, ip: "33.33.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network :public_network


  # VirtualBox Settings:
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048"]
  end

  config.ssh.max_tries = 40
  config.ssh.timeout   = 120

  # Enabling the Berkshelf plugin. To enable this globally, add this configuration
  # option to your ~/.vagrant.d/Vagrantfile file
  config.berkshelf.enabled = true

  config.vm.provision :chef_solo do |chef|
    chef.json = {
      :mysql => {
        :server_root_password => 'rootpass',
        :server_debian_password => 'password',
        :server_repl_password => 'password'
      },
      :users => [
        {:sitecode => 'abc', :comment => 'www.abc.com'},
      ],
    }

    chef.run_list = [
        "recipe[candide::default]"
    ]
  end
end
