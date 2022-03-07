#!/bin/bash

# move the hosts file
sudo cp hosts /etc/hosts

# copy the cloud.cfg file
sudo cp cloud.cfg /etc/cloud.cfg

# set the hostname
sudo hostnamectl set-hostname nginx01-emily

# create the named sudo user
sudo adduser emily-crawford
sudo usermod -aG sudo emily-crawford
sudo usermod -aG adm emily-crawford

# install nginx

sudo apt install nginx -y
sudo cp index.html /var/www/html/
sudo systemctl restart nginx

# copy rsyslog config
sudo cp sec350.conf /etc/rsyslog.d/sec350.conf
sudo systemctl restart rsyslog 


echo "done, restart machine for name change"
