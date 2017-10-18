# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  config.vm.define "cos7"
  config.vm.network "private_network", ip: "192.168.30.10"

  config.vm.synced_folder ".", "/vagrant",type: "virtualbox"
  config.vm.provision "shell", :privileged => false, :path => "./provision/base.sh"
end
