#!/bin/bash

sudo swapoff -a
sudo apt install -y nano

# keep swap off after reboot
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
# Edit /etc/fstab file to remove (or comment out) any swap entry,
# or add the swapoff -a instruction on your bashrc.

##Install openssh server
sudo apt install openssh-server

sudo apt-get update
sudo apt-get upgrade -y

# Install docker, kubernetes repository and pgp key,
# since it will be used in both master & worker VMs
sudo apt-get install -y docker.io

sudo apt install -y curl
# Add kubernetes to the apt repository
# list: Run a shell with sudo and give the command to it by using the -c option:
sudo apt update
sudo apt install -y apt-transport-https
sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

# initialize master:
sudo systemctl enable docker.service
#sudo systemctl daemon-reload
sudo systemctl restart kubelet


1
