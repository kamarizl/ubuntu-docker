# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu-docker"
  config.vm.box_url = "box/ubuntu-docker.box"
  config.vm.hostname = "ubuntu"

  # add another network interface :)
  config.vm.network "public_network", bridge: "Realtek PCIe GBE Family Controller"
  # config.vm.network "private_network", ip: "192.168.33.

  # manual ip
  # config.vm.provision "shell",
    # run: "always",
    # inline: "ifconfig eth1 192.168.0.17 netmask 255.255.255.0 up"

  # config.vm.synced_folder "../data", "/vagrant_data"

  config.vm.provider "virtualbox" do |vb|
    # vb.gui = true
    vb.name = "ubuntu-docker"
    vb.memory = "2048"
    vb.cpus = 2
  end

end
