#!/bin/sh

RIAK_VERSION="1.4.0"

# Install riak
cd ~/
mkdir ~/riak_install
cd ~/riak_install
echo 'Install riak'
#please note the 1.3 left in this link plz
wget http://s3.amazonaws.com/downloads.basho.com/riak/1.4/$RIAK_VERSION/riak-$RIAK_VERSION.tar.gz

#wget http://s3.amazonaws.com/downloads.basho.com/riak/1.3/1.3.2/riak-1.3.2.tar.gz
#tar -zxf riak-$1.3.2.tar.gz
#cd ~/riak_install/riak-1.3.2/
#make rel
#cp -r ~/riak_install/riak-1.3.2/rel/riak ~/

tar -zxf riak-$RIAK_VERSION.tar.gz
cd ~/riak_install/riak-$RIAK_VERSION/
make rel
make devrel DEVNODES=4
cp -r ~/riak_install/riak-$RIAK_VERSION/rel/riak ~/
mkdir ~/riak_dev
cp -r ~/riak_install/riak-$RIAK_VERSION/dev ~/riak_dev
# cp -r ~/riak_install/riak-1.3.2/rel/riak ~/riak-$RIAK_VERSION/
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
#rm -rf ~/riak_install 
