#!/bin/bash
sudo yum update -y
sudo yum install docker -y
sudo systemctl start docker
sudo systemctl enable docker
sudo yum install amazon-efs-utils -y
sudo mkdir /mnt/efs/
sudo usermod -aG docker ec2-user
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo mv /usr/local/bin/docker-compose /bin/docker-compose
sudo curl -sL "https://raw.githubusercontent.com/Gabriel-Torino/Atividade02-docker/main/dockercompose.yaml" --output "/home/ec2-user/dockercompose.yaml"
sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport fs-06bb3ec200e201714.efs.us-east-1.amazonaws.com:/ efs
sudo chown ec2-user:ec2-user /mnt/efs
sudo echo "fs-06bb3ec200e201714.efs.us-east-1.amazonaws.com:/ /mnt/efs nfs defaults 0 0" >> /etc/fstab

