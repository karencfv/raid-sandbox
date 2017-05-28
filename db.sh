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
debconf-set-selections <<< 'mdadm mdadm/daemon_options string --syslog'
#debconf-set-selections <<< 'mdadm mdadm/verbose boolean true'

apt-get update

apt-get install -y mysql-server initramfs-tools mdadm

#apt-get -q -y install mdadm --no-install-recommends
