#!/bin/bash

# move the hosts file
sudo cp hosts /etc/hosts

# copy the cloud.cfg file
sudo cp cloud.cfg /etc/cloud.cfg

# set the hostname
sudo hostnamectl set-hostname dhcp01-emily

# create the named sudo user
sudo adduser emily-crawford
sudo usermod -aG sudo emily-crawford
sudo usermod -aG adm emily-crawford

# install dhcp

sudo apt install isc-dhcp-server -y
sudo cp dhcpd.conf /etc/dhcp/dhcpd.conf
sudo cp isc-dhcp-server /etc/default/isc-dhcp-server
sudo systemctl restart isc-dhcp-server


# copy rsyslog config
sudo cp sec350.conf /etc/rsyslog.d/sec350.conf
sudo systemctl restart rsyslog 


echo "done, restart machine for name change"
