# -*- mode: ruby -*-
# vi: set ft=ruby :

# Multi-machine setup.
# 2 apache server master - slave
# 3 mysql DB 1 master - 2 slaves

BOX_IMAGE = "debian/jessie64"
WEB_NODE_COUNT = 1
DB_NODE_COUNT = 2

Vagrant.configure("2") do |config|
  config.vm.define "web", primary: true do |subconfig|
    subconfig.vm.box = BOX_IMAGE
    subconfig.vm.hostname = "web"
    subconfig.vm.network :private_network, ip: "10.0.0.10"
    subconfig.vm.provision "shell", path: "web.sh"
    subconfig.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "768"]
    end
  end

  (1..WEB_NODE_COUNT).each do |i|
    config.vm.define "web-node#{i}", autostart: false do |subconfig|
      subconfig.vm.box = BOX_IMAGE
      subconfig.vm.hostname = "web-node#{i}"
      subconfig.vm.network :private_network, ip: "10.0.0.#{i + 10}"
      subconfig.vm.provision "shell", path: "web.sh"
      subconfig.vm.provider "virtualbox" do |vb|
        vb.customize ["modifyvm", :id, "--memory", "520"]
      end
    end
  end

  config.vm.define "db", primary: true do |subconfig|
    subconfig.vm.box = BOX_IMAGE
    subconfig.vm.hostname = "db"
    subconfig.vm.network :private_network, ip: "10.0.0.20"
    subconfig.vm.provision "shell", path: "db.sh"
    subconfig.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "768"]
    end
  end

  (1..DB_NODE_COUNT).each do |i|
    config.vm.define "db-node#{i}", autostart: false do |subconfig|
      subconfig.vm.box = BOX_IMAGE
      subconfig.vm.hostname = "db-node#{i}"
      subconfig.vm.network :private_network, ip: "10.0.0.#{i + 20}"
      subconfig.vm.provision "shell", path: "db.sh"
      subconfig.vm.provider "virtualbox" do |vb|
        vb.customize ["modifyvm", :id, "--memory", "520"]
      end
    end
  end

end 
