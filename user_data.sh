#!/bin/bash

yum update -y
yum install amazon-efs-utils -y
yum install mysql -y
mkdir /mnt/efs/carol/var/www/html
yum install docker -y
systemctl start docker
systemctl enable docker
sudo usermod -aG docker ec2-user
sudo chkconfig docker on
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo mv /usr/local/bin/docker-compose /bin/docker-compose
sudo curl -sL "https://raw.githubusercontent.com/CarolinaSFreitas/Atividade2-PB/main/src/dockercompose.yaml" --output /home/ec2-user/dockercompose.yaml
sudo mount -t efs -o tls fs-02e8e2bba17248bd6:/ efs
chown ec2-user:ec2-user /mnt/efs
echo "fs-02e8e2bba17248bd6.efs.us-east-1.amazonaws.com:/ /mnt/efs nfs defaults 0 0" >> /etc/fstab
docker-compose -f /home/ec2-user/dockercompose.yaml up -d
