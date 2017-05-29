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
      vb.customize ["modifyvm", :id, "--memory", "512"]
    end
  end

  (1..WEB_NODE_COUNT).each do |i|
    config.vm.define "web-node#{i}", autostart: false do |subconfig|
      subconfig.vm.box = BOX_IMAGE
      subconfig.vm.hostname = "web-node#{i}"
      subconfig.vm.network :private_network, ip: "10.0.0.#{i + 10}"
      subconfig.vm.provision "shell", path: "web.sh"
      subconfig.vm.provider "virtualbox" do |vb|
        vb.customize ["modifyvm", :id, "--memory", "512"]
      end
    end
  end

  config.vm.define "db-raid0" do |subconfig|
    subconfig.vm.box = BOX_IMAGE
    subconfig.vm.hostname = "db-raid0"
    subconfig.vm.network :private_network, ip: "10.0.0.20"
    subconfig.vm.provision "shell", path: "db.sh"
    subconfig.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "512"]
      unless File.exist?('db_disk0.vdi' || 'db_disk1.vdi')
        vb.customize ['createhd', '--filename', 'db_disk0', '--size', 512]
        vb.customize ['createhd', '--filename', 'db_disk1', '--size', 512]
      end
      # Attach disks
      # vb.customize ['storagectl', :id, '--name', 'SATA Controller', '--add', 'sata']
      vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', '1', '--device', 0, '--type', 'hdd', '--medium', 'db_disk0.vdi']
      vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', '2', '--device', 0, '--type', 'hdd', '--medium', 'db_disk1.vdi']
    end
    subconfig.vm.provision "shell", path: "raidlevels/raid0.sh"
  end

  config.vm.define "db-raid1" do |subconfig|
    subconfig.vm.box = BOX_IMAGE
    subconfig.vm.hostname = "db-raid1"
    subconfig.vm.network :private_network, ip: "10.0.0.21"
    subconfig.vm.provision "shell", path: "db.sh"
    subconfig.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "512"]
      unless File.exist?('db1_disk0.vdi' || 'db1_disk1.vdi')
        vb.customize ['createhd', '--filename', 'db1_disk0', '--size', 512]
        vb.customize ['createhd', '--filename', 'db1_disk1', '--size', 512]
      end
      # Attach disks
      # vb.customize ['storagectl', :id, '--name', 'SATA Controller', '--add', 'sata']
      vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', '1', '--device', 0, '--type', 'hdd', '--medium', 'db1_disk0.vdi']
      vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', '2', '--device', 0, '--type', 'hdd', '--medium', 'db1_disk1.vdi']
    end
    subconfig.vm.provision "shell", path: "raidlevels/raid1.sh"
  end

  config.vm.define "db-raid5" do |subconfig|
    subconfig.vm.box = BOX_IMAGE
    subconfig.vm.hostname = "db-raid5"
    subconfig.vm.network :private_network, ip: "10.0.0.22"
    subconfig.vm.provision "shell", path: "db.sh"
    subconfig.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "512"]
      unless File.exist?('db5_disk0.vdi' || 'db5_disk1.vdi' || 'db5_disk2.vdi')
        vb.customize ['createhd', '--filename', 'db5_disk0', '--size', 512]
        vb.customize ['createhd', '--filename', 'db5_disk1', '--size', 512]
        vb.customize ['createhd', '--filename', 'db5_disk2', '--size', 512]
      end
      # Attach disks
      # vb.customize ['storagectl', :id, '--name', 'SATA Controller', '--add', 'sata']
      vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', '1', '--device', 0, '--type', 'hdd', '--medium', 'db5_disk0.vdi']
      vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', '2', '--device', 0, '--type', 'hdd', '--medium', 'db5_disk1.vdi']
      vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', '3', '--device', 0, '--type', 'hdd', '--medium', 'db5_disk2.vdi']
    end
    subconfig.vm.provision "shell", path: "raidlevels/raid5.sh"
  end

  config.vm.define "db-raid6" do |subconfig|
    subconfig.vm.box = BOX_IMAGE
    subconfig.vm.hostname = "db-raid6"
    subconfig.vm.network :private_network, ip: "10.0.0.23"
    subconfig.vm.provision "shell", path: "db.sh"
    subconfig.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "512"]
      unless File.exist?('db6_disk0.vdi' || 'db6_disk1.vdi' || 'db6_disk2.vdi' || 'db6_disk3.vdi')
        vb.customize ['createhd', '--filename', 'db6_disk0', '--size', 512]
        vb.customize ['createhd', '--filename', 'db6_disk1', '--size', 512]
        vb.customize ['createhd', '--filename', 'db6_disk2', '--size', 512]
        vb.customize ['createhd', '--filename', 'db6_disk3', '--size', 512]
      end
      # Attach disks
      # vb.customize ['storagectl', :id, '--name', 'SATA Controller', '--add', 'sata']
      vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', '1', '--device', 0, '--type', 'hdd', '--medium', 'db6_disk0.vdi']
      vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', '2', '--device', 0, '--type', 'hdd', '--medium', 'db6_disk1.vdi']
      vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', '3', '--device', 0, '--type', 'hdd', '--medium', 'db6_disk2.vdi']
      vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', '4', '--device', 0, '--type', 'hdd', '--medium', 'db6_disk3.vdi']
    end
    subconfig.vm.provision "shell", path: "raidlevels/raid6.sh"
  end

  config.vm.define "db-raid10" do |subconfig|
    subconfig.vm.box = BOX_IMAGE
    subconfig.vm.hostname = "db-raid10"
    subconfig.vm.network :private_network, ip: "10.0.0.24"
    subconfig.vm.provision "shell", path: "db.sh"
    subconfig.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "512"]
      unless File.exist?('db10_disk0.vdi' || 'db10_disk1.vdi' || 'db10_disk2.vdi' || 'db10_disk3.vdi')
        vb.customize ['createhd', '--filename', 'db10_disk0', '--size', 512]
        vb.customize ['createhd', '--filename', 'db10_disk1', '--size', 512]
        vb.customize ['createhd', '--filename', 'db10_disk2', '--size', 512]
        vb.customize ['createhd', '--filename', 'db10_disk3', '--size', 512]
      end
      # Attach disks
      # vb.customize ['storagectl', :id, '--name', 'SATA Controller', '--add', 'sata']
      vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', '1', '--device', 0, '--type', 'hdd', '--medium', 'db10_disk0.vdi']
      vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', '2', '--device', 0, '--type', 'hdd', '--medium', 'db10_disk1.vdi']
      vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', '3', '--device', 0, '--type', 'hdd', '--medium', 'db10_disk2.vdi']
      vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', '4', '--device', 0, '--type', 'hdd', '--medium', 'db10_disk3.vdi']
    end
    subconfig.vm.provision "shell", path: "raidlevels/raid10.sh"
  end


#  (1..DB_NODE_COUNT).each do |i|
#    config.vm.define "db-node#{i}", autostart: false do |subconfig|
#      subconfig.vm.box = BOX_IMAGE
#      subconfig.vm.hostname = "db-node#{i}"
#      subconfig.vm.network :private_network, ip: "10.0.0.#{i + 20}"
#      subconfig.vm.provision "shell", path: "db.sh"
#      subconfig.vm.provider "virtualbox" do |vb|
#        vb.customize ["modifyvm", :id, "--memory", "512"]
#      end
#    end
#  end
end
