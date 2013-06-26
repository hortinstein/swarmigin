#!/bin/sh

# Install node.js
mkdir ~/node-install
cd ~/node-install
wget http://nodejs.org/dist/v0.8.21/node-v0.8.21.tar.gz
tar -zxf node-v0.8.21.tar.gz
echo 'installing node.js'
cd ~/node-install/node-v0.8.21
./configure && make && checkinstall --install=yes --pkgname=nodejs --pkgversion "0.8.21" --default
npm install -g nave
nave install latest
echo 'node.js install completed'


# Install erlang
mkdir ~/erlang-install
cd ~/erlang-install
echo 'installing erlang'
wget http://erlang.org/download/otp_src_R15B01.tar.gz
tar -zxf otp_src_R15B01.tar.gz
cd ~/erlang-install/otp_src_R15B01
./configure && make && sudo make install
echo 'erlang install complete'

# Install riak
cd ~/
mkdir ~/riak-install
cd ~/riak-install
echo 'Install riak'
wget http://s3.amazonaws.com/downloads.basho.com/riak/1.3/1.3.0/riak-1.3.0.tar.gz
tar -zxf riak-1.3.0.tar.gz
cd ~/riak-install/riak-1.3.0/
make rel
cp -r ~/riak-install/riak-1.3.0/rel/riak ~/riak-1.3.0/
ln -s ~/riak-1.3.0/bin/riak /usr/bin/riak
ln -s ~/riak-1.3.0/bin/riak-admin /usr/bin/riak-admin
ln -s ~/riak-1.3.0/bin/search-cmd /usr/bin/search-cmd
echo 'riak install complete'

echo 'installing node daemon'
cd ~/
npm -g install forever
git clone git://github.com/hortinstein/swarmlicant.git
cd ~/swarmlicant/
npm install
cp upstart/swarmlicant.conf /etc/init
cd ~/

echo 'making config directories'
mkdir ~/configs/


echo 'cleanup'
rm -rf ~/riak-install ~/erlang-install ~/node-install 