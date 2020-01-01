echo "Startig Postres Database"  >> /home/ec2-user/startup.log
runuser -l postgres -c "/usr/lib64/pgsql95/bin/pg_ctl -D /opt/pgdata -l /opt/pgdata/logs/pglog.log start"
echo "Waiting for Database to start"  >> /home/ec2-user/startup.log
sleep 45
echo "Postres Database Startup Complete"  >> /home/ec2-user/startup.log


echo "Starting Redis Server"  >> /home/ec2-user/startup.log
cd /home/ec2-user/redis
runuser -l ec2-user -c 'nohup redis-server /etc/redis/redis.conf &'
echo "Redis Server Startup Complete"  >> /home/ec2-user/startup.log

echo "Starting Mosquitto Server"  >> /home/ec2-user/startup.log
cd /home/ec2-user/mosquitto
runuser -l ec2-user -c 'nohup /usr/sbin/mosquitto -c /etc/mosquitto/mosquitto.conf &'
echo "Mosquitto Server Startup Complete" >> /home/ec2-user/startup.log

cd /opt/lora-gateway-bridge/bin  
echo "Starting Lora Gateway Server" >> /home/ec2-user/startup.log
runuser -l ec2-user -c  'nohup /opt/lora-gateway-bridge/bin/lora-gateway-bridge --log-level 5 > /var/log/lora-gateway-bridge/lora-gateway.log 2>&1 &'
echo "Lora Gateway Server Startup Complete" >> /home/ec2-user/startup.log

echo "Starting Lora App Server"  >> /home/ec2-user/startup.log
runuser -l ec2-user -c 'nohup /opt/lora-app-server/bin/lora-app-server --db-automigrate --postgres-dsn "postgres://loraserver:dbpassword@localhost/loraserver?sslmode=disable" --http-tls-key "/opt/lora-app-server/certs/http-key.pem" --http-tls-cert "/opt/lora-app-server/certs/http.pem" > /var/log/lora-app-server/lora-app.log 2>&1 &'
echo "Lora App Server Startup Complete"  >> /home/ec2-user/startup.log

cd /opt/loraserver/bin
echo "Starting Lora Network Server" >> /home/ec2-user/startup.log
runuser -l ec2-user -c 'nohup /opt/loraserver/bin/loraserver --net-id 0a0b09 --band US_902_928 > /var/log/loraserver/loraserver.log 2>&1 &'
echo "Lora Network Server Startup Complete" >> /home/ec2-user/startup.log

cd /home/ec2-user
