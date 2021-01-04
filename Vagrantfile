# -*- mode: ruby -*-
# vi: set ft=ruby :

###################################################################
#Script Name	: Vagrantfile
#Description	: Kubernetes Cluster - simple
#Args         : None
#Author       : James Cox
#Email        : jpaulcox@hotmail.com
#GitHub Repo  : https://github.com/jpaulcox/kuberntes-cluster-simple
###################################################################


servers = [
    {
        :name => "controlplane",
        :type => "master",
        :box => "aspyatkin/ubuntu-18.04-server",
        :box_version => "1.0.1",
        :network => "public_network", #"private_network, bridged" "public_network" "bridged"
        :eth1 => "192.168.1.200", # Network needs to match your home network
        :mem => "3064",
        :cpu => "2",
        :role => "" # "Grafana, Wordpress"
    },
    {
        :name => "node01",
        :type => "node",
        :box => "aspyatkin/ubuntu-18.04-server",
        :box_version => "1.0.1",
        :network => "public_network",
        :eth1 => "192.168.1.201",
        :mem => "3064",
        :cpu => "2",
        :role => "" # "Grafana, Wordpress"
    },
    {
        :name => "node02",
        :type => "node",
        :box => "aspyatkin/ubuntu-18.04-server",
        :box_version => "1.0.1",
        :network => "public_network",
        :eth1 => "192.168.1.202",
        :mem => "3064",
        :cpu => "2",
        :role => "" # "Grafana, Wordpress"
    }
]



Vagrant.configure("2") do |config|

    servers.each do |opts|
        config.vm.define opts[:name] do |config|

            config.vm.box = opts[:box]
            config.vm.box_version = opts[:box_version]
            config.vm.hostname = opts[:name]
            config.vm.network opts[:network], ip: opts[:eth1]

            config.vm.provider "virtualbox" do |v|

                v.name = opts[:name]
            	 # v.customize ["modifyvm", :id, "--groups", "DevOps"]
                v.customize ["modifyvm", :id, "--memory", opts[:mem]]
                v.customize ["modifyvm", :id, "--cpus", opts[:cpu]]
            end

            # System Configurations
             config.vm.provision "shell", path: "scripts/base-setup.sh"
             if opts[:type] == "master"
               config.vm.provision "shell", path: "scripts/master.sh"
             else
               config.vm.provision "shell", path: "scripts/node.sh"
             end
           end
         end
end
