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
useradd -m -d /home/swarmlicant swarmlicant

#adds to the sudo group
#usermod -a -G sudo swarmlicant

mkdir /home/swarmlicant
mkdir /home/swarmlicant/.ssh
chmod 700 /home/swarmlicant/.ssh

echo 'running new commands as user'
#su -c ./swarmlicant_build.sh swarmlicant
./swarmlicant_build.sh