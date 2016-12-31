!#/bin/bash
echo "Install Mosquitto Server" >> /home/ec2-user/install.log
cd /home/ec2-user
mkdir mosquitto
echo "[home_oojah_mqtt]" > mosquitto/mosquitto.repo
echo "name=mqtt (CentOS_CentOS-7)" >> mosquitto/mosquitto.repo
echo "type=rpm-md" >> mosquitto/mosquitto.repo
echo "baseurl=http://download.opensuse.org/repositories/home:/oojah:/mqtt/CentOS_CentOS-7/" >> mosquitto/mosquitto.repo
echo "gpgcheck=1" >> mosquitto/mosquitto.repo
echo "gpgkey=http://download.opensuse.org/repositories/home:/oojah:/mqtt/CentOS_CentOS-7//repodata/repomd.xml.key" >> mosquitto/mosquitto.repo
echo "enabled=1" >> mosquitto/mosquitto.repo

cp mosquitto/mosquitto.repo /etc/yum.repos.d/ 
yum -y install mosquitto
yum -y install mosquitto-clients
mkdir /var/log/mosquitto
chmod -R +rw  /var/log/mosquitto
chown ec2-user /var/log/mosquitto
sed -i -- "s/persistence true/persistence false/g" /etc/mosquitto/mosquitto.conf
sed -i -- "s/#log_dest/log_dest/g" /etc/mosquitto/mosquitto.conf
echo "Starting Mosquitto Server"  >> /home/ec2-user/install.log
chown ec2-user mosquitto
cd mosquitto
runuser -l ec2-user -c 'nohup /usr/sbin/mosquitto -c /etc/mosquitto/mosquitto.conf &'
echo "Mosquitto Server Install Complete" >> /home/ec2-user/install.log

