!#/bin/bash
echo "Install Lora Gateway Server"
cd /home/ec2-user
useradd -M -r -s /bin/false gatewaybridge
mkdir -p /opt/lora-gateway-bridge/bin
cp lora-install/lora-gateway-bridge /opt/lora-gateway-bridge/bin
chmod +w /opt/lora-gateway-bridge/bin
mkdir -p /var/log/lora-gateway-bridge
chmod -R +rw /var/log/lora-gateway-bridge 
chown -R ec2-user /var/log/lora-gateway-bridge
chown -R ec2-user /opt/lora-gateway-bridge/bin
cd /opt/lora-gateway-bridge/bin
echo "Starting Lora Gateway Server"
runuser -l ec2-user -c 'nohup /opt/lora-gateway-bridge/bin/lora-gateway-bridge --log-level 5 > /var/log/lora-gateway-bridge/lora-gateway.log 2>&1 &'
echo "Lora Gateway Server Install Complete"
