#!/usr/bin/env bash
export DEBIAN_FRONTEND=noninteractive

apt-get update

debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'

debconf-set-selections <<< 'mdadm mdadm/mail_to string root'
debconf-set-selections <<< 'mdadm mdadm/initrdstart string all'
debconf-set-selections <<< 'mdadm mdadm/autostart boolean true'
debconf-set-selections <<< 'mdadm mdadm/autocheck boolean true'
debconf-set-selections <<< 'mdadm mdadm/initrdstart_notinconf boolean false'
debconf-set-selections <<< 'mdadm mdadm/start_daemon boolean true'

apt-get -y install mysql-server initramfs-tools mdadm
