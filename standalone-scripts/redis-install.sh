!#/bin/bash

echo "Install Redis Server"
cd /home/ec2-user
echo "Install gcc and make"
sudo sudo yum -y install gcc make
echo "Download Redis"
wget http://download.redis.io/releases/redis-3.2.0.tar.gz
tar xzf redis-3.2.0.tar.gz
cd redis-3.2.0
echo "Make Redis"
make distclean
make
sudo make install
sudo cp src/redis-server src/redis-cli /usr/local/bin
sudo cp src/redis-sentinel src/redis-benchmark src/redis-check-aof src/redis-check-rdb /usr/local/bin
sudo mkdir /etc/redis
sudo chmod -R +rw /etc/redis
sudo cp redis.conf /etc/redis/.
nohup redis-server /etc/redis/redis.conf &
echo "Redis Install Complete"