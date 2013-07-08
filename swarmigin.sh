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

NODE_VERSION="0.10.12"
ERLANG_VERSION="R15B01"

#update the system
echo 'System Update'
apt-get -y update
apt-get -y upgrade
echo 'Update completed'

#install node/erlang deps
apt-get -y install libssl-dev pkg-config fail2ban build-essential curl gcc g++ checkinstall libncurses5-dev openssl libssl-dev git

#installing node
mkdir ~/node_install
cd ~/node_install
echo 'installing node'
wget http://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION.tar.gz
tar -zxf node-v$NODE_VERSION.tar.gz
echo "installing node.js $NODE_VERSION"
cd ~/node_install/node-v$NODE_VERSION
./configure && make && checkinstall --install=yes --pkgname=nodejs --pkgversion "$NODE_VERSION" --default
npm -g install forever
npm install -g nave
nave install latest
echo 'node.js install completed'

# Install erlang
mkdir ~/erlang_install
cd ~/erlang_install
echo 'installing erlang'
wget http://erlang.org/download/otp_src_$ERLANG_VERSION.tar.gz
tar -zxf otp_src_$ERLANG_VERSION.tar.gz
cd ~/erlang_install/otp_src_$ERLANG_VERSION
./configure && make && sudo make install
echo 'erlang install complete'

#creating swarmlicant as a user and nessecary services
useradd -m swarmlicant
mkdir /home/swarmlicant/logs 
chown swarmlicant:adm /home/swarmlicant/logs 
cd ~/swarmigin/
mkdir /home/swarmlicant/build_scripts
cp /root/swarmigin/swarmlicant_build.sh /home/swarmlicant/build_scripts/
chown swarmlicant:swarmlicant /home/swarmlicant/build_scripts

echo 'running new commands as user'
su -c /home/swarmlicant/build_scripts/swarmlicant_build.sh swarmlicant

#copying swarmlicant startup to upstart
cp ~/swarmigin/swarmlicant.conf /etc/init
