#!/bin/sh

RIAK_VERSION="1.3.2"

# Install riak
cd ~/
mkdir ~/riak_install
cd ~/riak_install
echo 'Install riak'
#please note the 1.3 left in this link plz
wget http://s3.amazonaws.com/downloads.basho.com/riak/1.3/$RIAK_VERSION/riak-$RIAK_VERSION.tar.gz
tar -zxf riak-$RIAK_VERSION.tar.gz
cd ~/riak_install/riak-$RIAK_VERSION/
make rel
cp -r ~/riak_install/riak-$RIAK_VERSION/rel/riak ~/riak-$RIAK_VERSION/
echo 'riak install complete'

echo 'installing node daemon'
cd ~/
git clone git://github.com/hortinstein/swarmlicant.git
cd ~/swarmlicant/
mkdir /home/swarmlicant/logs
npm install
cd ~/

echo 'making config directories'
mkdir ~/configs/


echo 'cleanup'
rm -rf ~/riak_install 
rm -rf ~/build_scripts