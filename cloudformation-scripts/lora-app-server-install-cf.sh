!#/bin/bash
echo "Install Lora App Server"  >> /home/ec2-user/install.log
cd /home/ec2-user
mkdir -p /opt/lora-app-server/bin
chmod +w /opt/lora-app-server/bin
mkdir -p /var/log/lora-app-server
chmod -R +rw /var/log/lora-app-server
chown -R ec2-user /var/log/lora-app-server
cp lora-install/lora-app-server /opt/lora-app-server/bin
mkdir -p /opt/lora-app-server/certs
chmod +rw /opt/lora-app-server/certs
echo "Create Certificates for server"  >> /home/ec2-user/install.log
openssl req -x509 -newkey rsa:4096 -keyout /opt/lora-app-server/certs/http-key.pem -out /opt/lora-app-server/certs/http.pem -days 365 -nodes
chmod +rw /opt/lora-app-server/certs/* 
chown -R ec2-user /opt/lora-app-server/certs
echo "Complete Create Certificates for server"  >> /home/ec2-user/install.log
chown -R ec2-user /opt/lora-app-server/bin
cd /opt/lora-app-server/bin
echo "Starting Lora App Server"  >> /home/ec2-user/install.log
runuser -l ec2-user -c 'nohup /opt/lora-app-server/bin/lora-app-server --db-automigrate --postgres-dsn "postgres://loraserver:dbpassword@localhost/loraserver?sslmode=disable" --http-tls-key "/opt/lora-app-server/certs/http-key.pem" --http-tls-cert "/opt/lora-app-server/certs/http.pem" > /var/log/lora-app-server/lora-app.log 2>&1 &'
echo "Lora App Server Install Complete"  >> /home/ec2-user/install.log


