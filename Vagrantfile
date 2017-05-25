# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|

  config.vm.define "pm" do |pm|
    pm.vm.box = "nrel/CentOS-6.5-x86_64"
    pm.vm.hostname = "pm"
    pm.vm.network "private_network", ip: "192.168.2.10"
    pm.vm.network "forwarded_port", guest: 8140, host: 8140
    pm.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", "3072"]
        vb.customize ["modifyvm", :id, "--cpus", "2"]
    end
  end
  config.vm.define "wiki" do |wiki|
    wiki.vm.box = "nrel/CentOS-6.5-x86_64"
    wiki.vm.hostname = "wiki"
    wiki.vm.network "private_network", ip: "192.168.2.20"
  end
  config.vm.define "wikitest" do |wikitest|
    wikitest.vm.box = "ubuntu/trusty64"
    wikitest.vm.hostname = "wikitest"
    wikitest.vm.network "private_network", ip: "192.168.2.30"
  end

end

