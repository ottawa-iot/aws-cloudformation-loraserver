!#/bin/bash
echo "Start LoRaWAN Install"  >> lorawan-install.log

echo "Install Docker "  >> lorawan-install.log

sudo yum install -y docker
sudo service docker start
sudo usermod -a -G docker ec2-user

echo "Docker Install Complete "  >> lorawan-install.log

echo "Install Mosquitto MQTT "  >> lorawan-install.log

sudo amazon-linux-extras install epel
sudo yum -y install mosquitto
sudo systemctl start mosquitto
sudo systemctl enable mosquitto

echo "Mosquitto MQTT Install Complete "  >> lorawan-install.log
