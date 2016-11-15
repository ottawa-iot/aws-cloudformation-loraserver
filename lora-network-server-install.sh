!#/bin/bash
echo "Install Lora Network Server"
cd /home/ec2-user
sudo useradd -M -r -s /bin/false loraserver
sudo mkdir -p /opt/loraserver/bin
sudo chmod +w /opt/loraserver/bin
sudo cp loraservers/loraserver /opt/loraserver/bin
sudo mkdir -p /var/log/loraserver
sudo chmod -R 777 /var/log/loraserver 
echo "Complete Install Lora Network Server"
cd /opt/loraserver/bin
echo "Starting Lora Network Server"
nohup ./loraserver --net-id 0a0b09 --band US_902_928 > /var/log/loraserver/loraserver.log 2>&1 &
echo "Lora Network Server Running"


