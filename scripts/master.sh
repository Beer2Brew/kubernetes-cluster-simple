#!/bin/bash

## Move to Master Script

HOST_NAME=$(hostname -s)
kubeadm init --apiserver-advertise-address=$IP_ADDR --apiserver-cert-extra-sans=$IP_ADDR  --node-name $HOST_NAME --pod-network-cidr=192.168.0.0/16
#  sudo kubeadm init --apiserver-advertise-address=192.168.205.10 --pod-network-cidr=192.168.0.0/16

#copying credentials to regular user - vagrant
sudo --user=vagrant mkdir -p /home/vagrant/.kube
cp -i /etc/kubernetes/admin.conf /home/vagrant/.kube/config
chown $(id -u vagrant):$(id -g vagrant) /home/vagrant/.kube/config
#  Installing a Network Policy Engine (Calico)
kubectl apply -f https://docs.projectcalico.org/v3.10/manifests/calico.yaml


# Config for Nodes
sudo kubeadm token create --print-join-command >> /etc/kubeadm_join_cmd.sh
  chmod +x /etc/kubeadm_join_cmd.sh
