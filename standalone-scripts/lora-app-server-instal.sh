!#/bin/bash
echo "Install Lora App Server"
cd /home/ec2-user
sudo mkdir -p /opt/lora-app-server/bin
sudo chmod +w /opt/lora-app-server/bin
sudo mkdir -p /var/log/lora-app-server
sudo chmod -R 777 /var/log/lora-app-server
sudo cp loraservers/lora-app-server /opt/lora-app-server/bin
sudo mkdir -p /opt/lora-app-server/certs
sudo chmod 777 /opt/lora-app-server/certs
echo "Complete Install Lora App Server"
echo "Create Certificates for server"
sudo openssl req -x509 -newkey rsa:4096 -keyout /opt/lora-app-server/certs/http-key.pem -out /opt/lora-app-server/certs/http.pem -days 365 -nodes
sudo chmod 777 /opt/lora-app-server/certs/* 
echo "Complete Create Certificates for server"
cd /opt/lora-app-server/bin
echo "Starting Lora App Server"
nohup ./lora-app-server --db-automigrate --postgres-dsn "postgres://loraserver:dbpassword@localhost/loraserver?sslmode=disable" --http-tls-key "/opt/lora-app-server/certs/http-key.pem" --http-tls-cert "/opt/lora-app-server/certs/http.pem" > /var/log/lora-app-server/lora-app.log 2>&1 &
echo "Lora App Server Running"


