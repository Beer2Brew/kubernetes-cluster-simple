#!/bin/bash
###################################################################
#Script Name	: master.sh
#Description	: Kubernetes Cluster - simple
#Args         : None
#Author       : James Cox
#Email        : jpaulcox@hotmail.com
#GitHub Repo  : https://github.com/jpaulcox/kuberntes-cluster-simple
###################################################################
set -x

logger() {
  DT=$(date '+%Y/%m/%d %H:%M:%S')
  echo "$DT $0: $1"
}
echo "Running"



echo "Configuring Kubernetes"
HOST_NAME=$(hostname -s)
echo "IP of this box"
IP_ADDR=$(ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/')
sudo kubeadm init --apiserver-advertise-address=$IP_ADDR --apiserver-cert-extra-sans=$IP_ADDR  --node-name $HOST_NAME --pod-network-cidr=192.168.0.0/16
#  sudo kubeadm init --apiserver-advertise-address=192.168.205.10 --pod-network-cidr=192.168.0.0/16

echo "copying credentials to regular user - vagrant"
#copying credentials to regular user - vagrant
sudo --user=vagrant mkdir -p /home/vagrant/.kube
sudo cp -i /etc/kubernetes/admin.conf /home/vagrant/.kube/config
# User this for Host System Lens apply
sudo cp -f /etc/kubernetes/admin.conf /vagrant/config
sudo chown $(id -u vagrant):$(id -g vagrant) /home/vagrant/.kube/config
#  Installing a Network Policy Engine (Calico)
kubectl apply -f https://docs.projectcalico.org/v3.10/manifests/calico.yaml

echo "Config for Nodes"
# Config for Nodes
kubeadm token create --print-join-command >> ~/kubeadm_join_cmd.sh
sudo mv ~/kubeadm_join_cmd.sh /etc/kubeadm_join_cmd.sh
sudo  chmod +x /etc/kubeadm_join_cmd.sh
