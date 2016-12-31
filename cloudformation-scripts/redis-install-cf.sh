!#/bin/bash

echo "Install Redis Server"  >> /home/ec2-user/install.log
cd /home/ec2-user
mkdir redis
chown ec2-user redis
echo "Install gcc and make"  >> /home/ec2-user/install.log
yum -y install gcc make
echo "Download Redis"  >> /home/ec2-user/install.log
wget http://download.redis.io/releases/redis-3.2.0.tar.gz
tar xzf redis-3.2.0.tar.gz
cd redis-3.2.0
echo "Make Redis"  >> /home/ec2-user/install.log
make distclean
make
make install
cp src/redis-server src/redis-cli /usr/local/bin
cp src/redis-sentinel src/redis-benchmark src/redis-check-aof src/redis-check-rdb /usr/local/bin
mkdir /etc/redis
chmod -R +rw /etc/redis
cp redis.conf /etc/redis/.
echo "Starting Redis Server"  >> /home/ec2-user/install.log
cd ../redis
runuser -l ec2-user -c 'nohup redis-server /etc/redis/redis.conf &'
echo "Redis Install Complete"  >> /home/ec2-user/install.log