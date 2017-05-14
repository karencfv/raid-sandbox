#!/usr/bin/env bash
export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y apache2

if ! [ -L /var/www  ]; then
  rm -rf /var/www
  ln -fs /vagrant /var/www
fi

apt-get -y install php5 libapache2-mod-php5
