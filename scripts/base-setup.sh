#!/bin/bash
###################################################################
#Script Name	: base-setup.sh
#Description	: Kubernetes Cluster - simple
#Args         : None
#Author       : James Cox
#Email        : jpaulcox@hotmail.com
#GitHub Repo  : https://github.com/jpaulcox/kuberntes-cluster-simple
###################################################################

sudo apt-get update
#sudo apt-get upgrade -y
echo "+++++++++++++++++++++++++++++++++++ Starting Swap Off +++++++++++++++++++++++++++++++++++++"
sudo swapoff -a
sudo apt install -y nano
# keep swap off after reboot
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
# Edit /etc/fstab file to remove (or comment out) any swap entry,
# or add the swapoff -a instruction on your bashrc.

echo "+++++++++++++++++++++++++++++++++++ Starting Docker Installs +++++++++++++++++++++++++++++++++++++"
# Install docker, kubernetes repository and pgp key,
# since it will be used in both master & worker VMs
sudo apt-get install -y docker.io
sudo apt install -y net-tools
#sudo systemctl restart docker.service

sudo apt-get update
#sudo apt-get upgrade -y
echo "+++++++++++++++++++++++++++++++++++ Starting Curl Installs +++++++++++++++++++++++++++++++++++++"

# export DEBIAN_FRONTEND=noninteractive
# sudo apt-get -qq -y install curl

export DEBIAN_FRONTEND=noninteractive && sudo -E apt-get -q --option \"Dpkg::Options::=--force-confold\" --assume-yes install curl

# UCF_FORCE_CONFOLD=1 DEBIAN_FRONTEND=noninteractive sudo apt-get  -qq -y install curl
# sudo apt install -y curl

echo "+++++++++++++++++++++++++++++++++++ Starting transport Installs +++++++++++++++++++++++++++++++++++++"
# Add kubernetes to the apt repository
# list: Run a shell with sudo and give the command to it by using the -c option:
sudo apt-get update
sudo apt-get install -y apt-transport-https

echo "+++++++++++++++++++++++++++++++++++ Adding key.gpg Installs +++++++++++++++++++++++++++++++++++++"

sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

echo "+++++++++++++++++++++++++++++++++++ Starting k8 Installs +++++++++++++++++++++++++++++++++++++"

sudo -E cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
echo "+++++++++++++++++++++++++++++++++++ Ending Installs +++++++++++++++++++++++++++++++++++++"
#
# # initialize master:
# sudo systemctl enable docker.service
# #sudo systemctl daemon-reload
# sudo systemctl restart kubelet
