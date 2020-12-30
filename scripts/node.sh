#!/bin/bash

echo "This is worker"
apt-get install -y sshpass
sshpass -p "vagrant" scp -o StrictHostKeyChecking=no vagrant@192.168.205.10:/etc/kubeadm_join_cmd.sh .
sh ./kubeadm_join_cmd.sh
