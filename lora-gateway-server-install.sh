!#/bin/bash
echo "Install Lora Gateway Server"
cd /home/ec2-user
sudo useradd -M -r -s /bin/false gatewaybridge
sudo mkdir -p /opt/lora-gateway-bridge/bin
sudo cp loraservers/lora-gateway-bridge /opt/lora-gateway-bridge/bin
sudo chmod +w /opt/lora-gateway-bridge/bin
sudo mkdir -p /var/log/lora-gateway-bridge
sudo chmod -R 777 /var/log/lora-gateway-bridge 
echo "Complete Install Lora Gateway Server"
cd /opt/lora-gateway-bridge/bin
echo "Starting Lora Gateway Server"
nohup ./lora-gateway-bridge --log-level 5 > /var/log/lora-gateway-bridge/lora-gateway.log 2>&1 &
echo "Lora Gateway Server Running"
