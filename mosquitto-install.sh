!#/bin/bash
echo "Install Mosquitto Server"
cd /home/ec2-user
mkdir mosquitto
echo "[home_oojah_mqtt]" > mosquitto/mosquitto.repo
echo "name=mqtt (CentOS_CentOS-7)" >> mosquitto/mosquitto.repo
echo "type=rpm-md" >> mosquitto/mosquitto.repo
echo "baseurl=http://download.opensuse.org/repositories/home:/oojah:/mqtt/CentOS_CentOS-7/" >> mosquitto/mosquitto.repo
echo "gpgcheck=1" >> mosquitto/mosquitto.repo
echo "gpgkey=http://download.opensuse.org/repositories/home:/oojah:/mqtt/CentOS_CentOS-7//repodata/repomd.xml.key" >> mosquitto/mosquitto.repo
echo "enabled=1" >> mosquitto/mosquitto.repo

sudo cp mosquitto/mosquitto.repo /etc/yum.repos.d/ 
sudo yum -y install mosquitto
sudo yum -y install mosquitto-clients
sudo mkdir /var/log/mosquitto
sudo chmod -R +rw  /var/log/mosquitto
sudo chown ec2-user /var/log/mosquitto
sudo sed -i -- "s/persistence true/persistence false/g" /etc/mosquitto/mosquitto.conf
sudo sed -i -- "s/#log_dest/log_dest/g" /etc/mosquitto/mosquitto.conf
nohup /usr/sbin/mosquitto -c /etc/mosquitto/mosquitto.conf &

