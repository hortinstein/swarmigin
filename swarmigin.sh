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

echo 'creating user'
useradd riak
mkdir /home/riak
mkdir /home/riak/.ssh
chmod 700 /home/deploy/.ssh

apt-get install fail2ban
#install nodes/erlang deps
apt-get -y install libssl-dev pkg-config build-essential curl gcc g++ checkinstall libncurses5-dev openssl libssl-dev git

# Install node.js
mkdir /tmp/node-install
cd /tmp/node-install
wget http://nodejs.org/dist/v0.8.21/node-v0.8.21.tar.gz
tar -zxf node-v0.8.21.tar.gz
echo 'installing node.js'
cd node-v0.8.21
./configure && make && checkinstall --install=yes --pkgname=nodejs --pkgversion "0.8.21" --default
npm install -g nave
nave install latest
echo 'node.js install completed'


# Install erlang
mkdir /tmp/erlang-install
cd /tmp/erlang-install
echo 'installing erlang'
wget http://erlang.org/download/otp_src_R15B01.tar.gz
tar -zxf otp_src_R15B01.tar.gz
cd otp_src_R15B01
./configure && make && sudo make install
echo 'erlang install complete'

# Install riak
mkdir /tmp/riak-install
cd /tmp/riak-install
echo 'Install riak'
wget http://s3.amazonaws.com/downloads.basho.com/riak/1.3/1.3.0/riak-1.3.0.tar.gz
tar -zxf riak-1.3.0.tar.gz
cd riak-1.3.0/
make rel
cp -r /tmp/riak-install/riak-1.3.0/rel/riak /home/riak-1.3.0/
ln -s /home/riak-1.3.0/bin/riak /usr/bin/riak
ln -s /home/riak-1.3.0/bin/riak-admin /usr/bin/riak-admin
ln -s /home/riak-1.3.0/bin/search-cmd /usr/bin/search-cmd
echo 'riak install complete'

echo 'installing node daemon'
npm -g install forever
git clone git://github.com/hortinstein/swarmlicant.git
cd swarmlicant/
npm install
cd ..
wget https://gist.github.com/hortinstein/5466442/raw/22f3d05f2c84feb41a85c6088582e437a5dabf07/swarmlicant.conf
cp swarmlicant.conf /etc/init

echo 'making config directories'
mkdir /home/configs/riak
mkdir /home/configs/swarmlicant


echo 'cleanup'
rm -rf /tmp/riak-install /tmp/erlang-install /tmp/node-install swarmlicant.conf