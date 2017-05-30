# -*- mode: ruby -*-
# vi: set ft=ruby :

# Multi-machine setup.
# 2 apache servers master - slave
# 5 mysql DB set up in different RAID level arrays

BOX_IMAGE = "debian/jessie64"

WEB_NODE_COUNT = 1

RAID0_DISKS  = 2
RAID1_DISKS  = 2
RAID5_DISKS  = 3
RAID6_DISKS  = 4
RAID10_DISKS = 4

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

  config.vm.define "db-raid0", autostart: false do |subconfig|
    subconfig.vm.box = BOX_IMAGE
    subconfig.vm.hostname = "db-raid0"
    subconfig.vm.network :private_network, ip: "10.0.0.20"
    subconfig.vm.provision "shell", path: "db.sh"
    subconfig.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "512"]
      (1..RAID0_DISKS).each do |i|
        disk_path = "raidlevels/disks/db-raid0-#{i}.vdi"
        unless File.exist?(disk_path)
          vb.customize ["createhd",
                        "--filename", disk_path,
                        "--size", 512]
        end
        vb.customize ["storageattach", :id,
                      "--storagectl", "SATA Controller",
                      "--port", "#{i}",
                      "--device", 0,
                      "--type", "hdd",
                      "--medium", disk_path]
      end
    end
    subconfig.vm.provision "shell", path: "raidlevels/raid0.sh"
  end

  config.vm.define "db-raid1", autostart: false do |subconfig|
    subconfig.vm.box = BOX_IMAGE
    subconfig.vm.hostname = "db-raid1"
    subconfig.vm.network :private_network, ip: "10.0.0.21"
    subconfig.vm.provision "shell", path: "db.sh"
    subconfig.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "512"]
      (1..RAID1_DISKS).each do |i|
        disk_path = "raidlevels/disks/db-raid1-#{i}.vdi"
        unless File.exist?(disk_path)
          vb.customize ["createhd",
                        "--filename", disk_path,
                        "--size", 512]
        end
        vb.customize ["storageattach", :id,
                      "--storagectl", "SATA Controller",
                      "--port", "#{i}",
                      "--device", 0,
                      "--type", "hdd",
                      "--medium", disk_path]
      end
    end
    subconfig.vm.provision "shell", path: "raidlevels/raid1.sh"
  end

  config.vm.define "db-raid5", autostart: false do |subconfig|
    subconfig.vm.box = BOX_IMAGE
    subconfig.vm.hostname = "db-raid5"
    subconfig.vm.network :private_network, ip: "10.0.0.22"
    subconfig.vm.provision "shell", path: "db.sh"
    subconfig.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "512"]
      (1..RAID5_DISKS).each do |i|
        disk_path = "raidlevels/disks/db-raid5-#{i}.vdi"
        unless File.exist?(disk_path)
          vb.customize ["createhd",
                        "--filename", disk_path,
                        "--size", 512]
        end
        vb.customize ["storageattach", :id,
                      "--storagectl", "SATA Controller",
                      "--port", "#{i}",
                      "--device", 0,
                      "--type", "hdd",
                      "--medium", disk_path]
      end
    end
    subconfig.vm.provision "shell", path: "raidlevels/raid5.sh"
  end

  config.vm.define "db-raid6", autostart: false do |subconfig|
    subconfig.vm.box = BOX_IMAGE
    subconfig.vm.hostname = "db-raid6"
    subconfig.vm.network :private_network, ip: "10.0.0.23"
    subconfig.vm.provision "shell", path: "db.sh"
    subconfig.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "512"]
      (1..RAID6_DISKS).each do |i|
        disk_path = "raidlevels/disks/db-raid6-#{i}.vdi"
        unless File.exist?(disk_path)
          vb.customize ["createhd",
                        "--filename", disk_path,
                        "--size", 512]
        end
        vb.customize ["storageattach", :id,
                      "--storagectl", "SATA Controller",
                      "--port", "#{i}",
                      "--device", 0,
                      "--type", "hdd",
                      "--medium", disk_path]
      end
    end
    subconfig.vm.provision "shell", path: "raidlevels/raid6.sh"
  end

  config.vm.define "db-raid10", autostart: false do |subconfig|
    subconfig.vm.box = BOX_IMAGE
    subconfig.vm.hostname = "db-raid10"
    subconfig.vm.network :private_network, ip: "10.0.0.24"
    subconfig.vm.provision "shell", path: "db.sh"
    subconfig.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "512"]
      (1..RAID10_DISKS).each do |i|
        disk_path = "raidlevels/disks/db-raid10-#{i}.vdi"
        unless File.exist?(disk_path)
          vb.customize ["createhd",
                        "--filename", disk_path,
                        "--size", 512]
        end
        vb.customize ["storageattach", :id,
                      "--storagectl", "SATA Controller",
                      "--port", "#{i}",
                      "--device", 0,
                      "--type", "hdd",
                      "--medium", disk_path]
      end
    end
    subconfig.vm.provision "shell", path: "raidlevels/raid10.sh"
  end
end
