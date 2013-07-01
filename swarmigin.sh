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

#creating swarmlicant as a user and nessecary services
useradd -m swarmlicant
su -c mkdir swarmlicant
mkdir /home/swarmlicant/logs 
chown swarmlicant:adm /home/swarmlicant/logs 

echo 'running new commands as user'
chmod +x swarmlicant_build.sh
chown -R swarmlicant:swarmlicant ./

su -c ./swarmlicant_build.sh swarmlicant
cp swarmlicant.conf /etc/init