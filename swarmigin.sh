#!/bin/sh
##############################################################
#
# baseline config for swarmlicant
# node, erlang, and riak installer
# ubuntu 13.04
# Author: Alex Hortin, email: hortinstein@gmail.com
# GitHub: https://github.com/hortinstein
#
##############################################################

echo 'System Update'
apt-get -y update
apt-get -y upgrade
echo 'Update completed'

apt-get install fail2ban
#install nodes/erlang deps
apt-get -y install libssl-dev pkg-config build-essential curl gcc g++ checkinstall libncurses5-dev openssl libssl-dev git

echo 'creating user'
useradd swarmlicant
mkdir /home/swarmlicant
mkdir /home/swarmlicant/.ssh
chmod 700 /home/swarmlicant/.ssh
su swarmlicant
./swarmlicant_build.sh
