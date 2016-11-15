#!/bin/bash

echo "Installing Postgres Database"
cd /home/ec2-user
sudo yum -y install postgresql95-server postgresql95-contrib
sudo mkdir /opt/pgdata
sudo chown postgres /opt/pgdata
cd /usr/lib64/pgsql95/bin
echo "Initializing Database"
sudo -u postgres ./initdb --pgdata=/opt/pgdata
sudo mkdir /opt/pgdata/logs
sudo chown postgres /opt/pgdata/logs
echo "Starting Database"
sudo -u postgres ./pg_ctl -D /opt/pgdata -l /opt/pgdata/logs/pglog.log start
cd /home/ec2-user
sudo echo "create role loraserver with login password 'dbpassword';" > ./loraconfig
sudo echo "create database loraserver with owner loraserver;" >> ./loraconfig
sudo cp ./loraconfig /var/lib/pgsql95/loraconfig
sudo chown postgres /var/lib/pgsql95/loraconfig
rm ./loraconfig
echo "Creating loraserver database"
cd /home
echo "Wait for database..."
sleep 5
sudo -u postgres psql -f /var/lib/pgsql95/loraconfig
cd /home/ec2-user
echo "Postres Database Install Complete"
