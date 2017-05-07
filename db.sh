#!/usr/bin/env bash

sudo apt-get update

debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
sudo apt-get install -y mysql-server

# Install mdadmn for RAID levels
# sudo apt-get install mdadm
# echo 'all' <- this did NOT work
