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
        :eth1 => "192.168.205.10",
        :mem => "2048",
        :cpu => "2"
    },
    {
        :name => "node01",
        :type => "node",
        :box => "aspyatkin/ubuntu-18.04-server",
        :box_version => "1.0.1",
        :eth1 => "192.168.205.11",
        :mem => "2048",
        :cpu => "2"
    # },
    # {
    #     :name => "node02",
    #     :type => "node",
    #     :box => "aspyatkin/ubuntu-18.04-server",
    #     :box_version => "20180831.0.0",
    #     :eth1 => "1.0.1",
    #     :mem => "2048",
    #     :cpu => "2"
    }
]



Vagrant.configure("2") do |config|

    servers.each do |opts|
        config.vm.define opts[:name] do |config|

            config.vm.box = opts[:box]
            config.vm.box_version = opts[:box_version]
            config.vm.hostname = opts[:name]
            config.vm.network :private_network, ip: opts[:eth1]

            config.vm.provider "virtualbox" do |v|

                v.name = opts[:name]
            	 v.customize ["modifyvm", :id, "--groups", "/DevOps"]
                v.customize ["modifyvm", :id, "--memory", opts[:mem]]
                v.customize ["modifyvm", :id, "--cpus", opts[:cpu]]

            end


             config.vm.provision "shell", path: "scripts/base-setup.sh"
              # if opts[:type] == "master"
                  # config.vm.provision "shell", path: "scripts/master.sh"
           # opts[:type] == "node"
                  # config.vm.provision "shell", path: "scripts/node.sh"
                #Error



            # config.vm.provision "shell", inline: <<-SHELL
            # cd /vagrant/scripts
            # sh ./base-setup.sh
            # SHELL
            # if opts[:type] == "master"
            #     config.vm.provision "shell", inline:<<-SHELL
            #     sh ./master.sh
            #     SHELL
            # else
            #     config.vm.provision "shell", inline:<<-SHELL
            #     sh  ./node.sh
            #     SHELL
            # end

       end

    end

end
