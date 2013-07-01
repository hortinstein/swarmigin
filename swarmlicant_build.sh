#!/bin/sh

NODE_VERSION="0.10.12"
ERLANG_VERSION="R16B01"
RIAK_VERSION="1.3.2"

# Install node.js
mkdir ~/node-install
cd ~/node-install
wget "http://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION.tar.gz"

tar -zxf node-v$NODE_VERSION.tar.gz
echo 'installing node.js $NODE_VERSION'
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

# Install riak
cd ~/
mkdir ~/riak-install
cd ~/riak-install
echo 'Install riak'
#please note the 1.3 left in this link plz
wget http://s3.amazonaws.com/downloads.basho.com/riak/1.3/$RIAK_VERSION/riak-$RIAK_VERSION.tar.gz
tar -zxf riak-$RIAK_VERSION.tar.gz
cd ~/riak-install/riak-$RIAK_VERSION/
make rel
cp -r ~/riak-install/riak-$RIAK_VERSION/rel/riak ~/riak-$RIAK_VERSION/
echo 'riak install complete'

echo 'installing node daemon'
cd ~/
npm -g install forever
git clone git://github.com/hortinstein/swarmlicant.git
cd ~/swarmlicant/
npm install
cd ~/

echo 'making config directories'
mkdir ~/configs/


echo 'cleanup'
rm -rf ~/riak-install ~/erlang-install ~/node-install 