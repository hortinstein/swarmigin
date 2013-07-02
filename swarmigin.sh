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
ERLANG_VERSION="R16B01"

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


mkdir ~/node_install
cd ~/node_install
echo 'installing node'
wget http://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION.tar.gz
tar -zxf node-v$NODE_VERSION.tar.gz
echo "installing node.js $NODE_VERSION"
cd ~/node-install/node-v$NODE_VERSION
./configure && make && checkinstall --install=yes --pkgname=nodejs --pkgversion "$NODE_VERSION" --default
npm install -g nave
nave install latest
echo 'node.js install completed'


# Install erlang
mkdir ~/erlang-install
cd ~/erlang-install
echo 'installing erlang'
wget http://erlang.org/download/otp_src_$ERLANG_VERSION.tar.gz
tar -zxf otp_src_$ERLANG_VERSION.tar.gz
cd ~/erlang-install/otp_src_$ERLANG_VERSION
./configure && make && sudo make install
echo 'erlang install complete'


cd ~/swarmigin/
chmod +x swarmlicant_build.sh
chown -R swarmlicant:swarmlicant ./

echo 'running new commands as user'
su -c root/swarmigin/swarmlicant_build.sh swarmlicant
cp ~/swarmigin/swarmlicant.conf /etc/init
