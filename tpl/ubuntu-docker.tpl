# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu",
  config.ssh.username = "docker",
  config.ssh.password = "docker"
end
