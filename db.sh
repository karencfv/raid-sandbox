#!/usr/bin/env bash
export DEBIAN_FRONTEND=noninteractive

debconf-set-selections <<< 'mysql-server mysql-server/root_password password rootpw'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password rootpw'

debconf-set-selections <<< 'mdadm mdadm/mail_to string root'
debconf-set-selections <<< 'mdadm mdadm/initrdstart string all'
debconf-set-selections <<< 'mdadm mdadm/autostart boolean true'
debconf-set-selections <<< 'mdadm mdadm/autocheck boolean true'
debconf-set-selections <<< 'mdadm mdadm/initrdstart_notinconf boolean false'
debconf-set-selections <<< 'mdadm mdadm/start_daemon boolean true'

apt-get update

apt-get install -y mysql-server initramfs-tools mdadm

# Create Raid0 array
mdadm --create --verbose /dev/md0 --level=0 --raid-devices=2 /dev/sdb /dev/sdc

# Create filesystem
mkfs.ext4 -F /dev/md0

# Mount point to attach the FS
mkdir -p /mnt/md0

# Mount FS
sudo mount /dev/md0 /mnt/md0

# Scan active array and append mdadm.conf file
mdadm --detail --scan | sudo tee -a /etc/mdadm/mdadm.conf

# Update initial RAM filesystem for the array to be available during early boot process
update-initramfs -u

# Add new FS optioms to etc/fstab file for automatic mounting at boot
echo '/dev/md0 /mnt/md0 ext4 defaults,nofail,discard 0 0' | tee -a /etc/fstab
