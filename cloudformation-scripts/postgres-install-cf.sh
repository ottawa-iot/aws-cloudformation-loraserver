#!/bin/bash

echo "Installing Postgres Database"  >> /home/ec2-user/install.log
cd /home/ec2-user
yum -y install postgresql95-server postgresql95-contrib
mkdir /opt/pgdata
chown postgres /opt/pgdata
cd /usr/lib64/pgsql95/bin
echo "Initializing Database"  >> /home/ec2-user/install.log
runuser -l postgres -c "/usr/lib64/pgsql95/bin/initdb --pgdata=/opt/pgdata"
mkdir /opt/pgdata/logs
chown postgres /opt/pgdata/logs
echo "Starting Database"  >> /home/ec2-user/install.log
runuser -l postgres -c "/usr/lib64/pgsql95/bin/pg_ctl -D /opt/pgdata -l /opt/pgdata/logs/pglog.log start"
cd /home/ec2-user
echo "create role loraserver with login password 'dbpassword';" > ./loraconfig
echo "create database loraserver with owner loraserver;" >> ./loraconfig
cp ./loraconfig /var/lib/pgsql95/loraconfig
chown postgres /var/lib/pgsql95/loraconfig
rm ./loraconfig
echo "Creating loraserver database"  >> /home/ec2-user/install.log
cd /home
echo "Wait for database..."  >> /home/ec2-user/install.log
sleep 5
runuser -l postgres -c "psql -f /var/lib/pgsql95/loraconfig"
cd /home/ec2-user
echo "Postres Database Install Complete"  >> /home/ec2-user/install.log
