#!/usr/bin/env bash

sudo apt-get update
sudo apt-get install -y apache2

if ! [ -L /var/www  ]; then
  rm -rf /var/www
  ln -fs /vagrant /var/www
fi

sudo apt-get -y install php5 libapache2-mod-php5
