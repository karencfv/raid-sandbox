#!/usr/bin/env bash
# Create RAID10 array
mdadm --create --verbose /dev/md0 --level=10 --raid-devices=4 /dev/sdb /dev/sdc /dev/sdd /dev/sde
# To use a different layout, or change the number of copies,
# you will have to use the --layout= option, which takes a layout and copy identifier.
# The layouts are n for near, f for far, and o for offset. The number of copies to store is appended afterwards.
#For instance, to create an array that has 3 copies in the offset layout, the command would look like this:
# mdadm --create --verbose /dev/md0 --level=10 --layout=o3 --raid-devices=4 /dev/sda /dev/sdb /dev/sdc /dev/sdd

# Create filesystem
mkfs.ext4 -F /dev/md0

# Mount point to attach the FS
mkdir -p /mnt/md0

# Mount FS
sudo mount /dev/md0 /mnt/md0

# Scan active array and append mdadm.conf file
mdadm --detail --scan | tee -a /etc/mdadm/mdadm.conf

# Update initial RAM filesystem for the array to be available during early boot process
update-initramfs -u

# Add new FS options to etc/fstab file for automatic mounting at boot
echo '/dev/md0 /mnt/md0 ext4 defaults,nofail,discard 0 0' | tee -a /etc/fstab
