!#/bin/bash
echo "Install Lora Network Server" >> /home/ec2-user/install.log
cd /home/ec2-user
useradd -M -r -s /bin/false loraserver
mkdir -p /opt/loraserver/bin
chmod +w /opt/loraserver/bin
cp lora-install/loraserver /opt/loraserver/bin
mkdir -p /var/log/loraserver
chmod -R +rw  /var/log/loraserver
chown -R ec2-user /var/log/loraserver 
chown -R ec2-user /opt/loraserver/bin
cd /opt/loraserver/bin
echo "Starting Lora Network Server" >> /home/ec2-user/install.log
runuser -l ec2-user -c 'nohup /opt/loraserver/bin/loraserver --net-id 0a0b09 --band US_902_928 > /var/log/loraserver/loraserver.log 2>&1 &'
echo "Lora Network Server Install Complete" >> /home/ec2-user/install.log


