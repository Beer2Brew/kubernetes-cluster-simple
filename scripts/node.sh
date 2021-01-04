#!/bin/bash
###################################################################
#Script Name	: node.sh
#Description	: Kubernetes Cluster - simple
#Args         : None
#Author       : James Cox
#Email        : jpaulcox@hotmail.com
#GitHub Repo  : https://github.com/jpaulcox/kuberntes-cluster-simple
###################################################################
echo "This is worker"
sudo apt-get install -y sshpass

sshpass -p "vagrant" scp -o 'StrictHostKeyChecking no'  vagrant@192.168.1.200:/etc/kubeadm_join_cmd.sh ~/
sudo sh ~/kubeadm_join_cmd.sh
