#!/bin/bash
###################################################################
#Script Name	:configureBox.sh
#Description	:Base configuraitons
#Args         :None
#Author       :James Cox
#Email        :jpaulcox@hotmail.com
#GitHub Repo  :https://github.com/jpaulcox/kuberntes-cluster-simple
###################################################################


set -x

logger() {
  DT=$(date '+%Y/%m/%d %H:%M:%S')
  echo "$DT $0: $1"
}
logger "Running"

logger "Install docker v17.03"
    # reason for not using docker provision is that it always installs latest version of the docker, but kubeadm requires 17.03 or older
    apt-get update
    apt-get install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
    add-apt-repository "deb https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable"
    apt-get update && apt-get install -y docker-ce=$(apt-cache madison docker-ce | grep 17.03 | head -1 | awk '{print $3}')

logger "Run docker commands as vagrant user (sudo not required)"
    usermod -aG docker vagrant

logger "Install kubeadm "
    apt-get install -y apt-transport-https curl
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
    cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
    deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
    apt-get update
    apt-get install -y kubelet kubeadm kubectl
    apt-mark hold kubelet kubeadm kubectl

logger "kubelet requires swap off"
    swapoff -a

logger "keep swap off after reboot"
    sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

logger "IP of this box"
    IP_ADDR=`ifconfig enp0s8 | grep Mask | awk '{print $2}'| cut -f2 -d:`
logger "Set node-IP"
    sudo sed -i "/^[^#]*KUBELET_EXTRA_ARGS=/c\KUBELET_EXTRA_ARGS=--node-ip=$IP_ADDR" /etc/default/kubelet
    sudo systemctl restart kubelet
