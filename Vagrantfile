# -*- mode: ruby -*-
# vi: set ft=ruby :
#
nodes = { 'elastic01'  => {
            :box       => 'centos-7.2-x64-virtualbox',
            :url       => 'http://boxes.netways.org/vagrant/centos/centos-7.2-x64-virtualbox.box',
            :memory    => '3096',
            :ip     => '192.168.5.10',
          },
          'elastic02'  => {
            :box       => 'centos-7.2-x64-virtualbox',
            :url       => 'http://boxes.netways.org/vagrant/centos/centos-7.2-x64-virtualbox.box',
            :memory    => '3096',
            :ip     => '192.168.5.20',
          },
}


# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  nodes.each_pair do |name, options|
    config.vm.define name do |node_config|
      node_config.vm.box = options[:box]
      node_config.vm.hostname = name
      node_config.vm.box_url = options[:url] if options[:url]
      node_config.vm.network :private_network, :adapter => 2, ip: options[:ip]
      node_config.vm.provider :virtualbox do |vb|
        vb.linked_clone = true if Vagrant::VERSION =~ /^1.8/
        vb.name = name
        vb.gui = false
        vb.customize ["modifyvm", :id,
          "--groups", "/Elastic Stack",
          "--memory", "256",
          "--audio", "none",
          "--usb", "on",
          "--usbehci", "off",
          "--nic2", "intnet",
          "--intnet2", "intnet",
        ]
        vb.memory = options[:memory] if options[:memory]
      end

      node_config.vm.provision :shell,
      :path => 'scripts/pre-install.sh'
      node_config.vm.provision :puppet do |puppet|
        puppet.manifests_path = "manifests"
        puppet.module_path = [ "modules.private", "modules" ]
        #puppet.hiera_config_path = "hiera.yaml"
      end
    end
  end


  config.vm.define "elastic01" do |elastic01|
    elastic01.vm.network "forwarded_port", guest: 5601, host: 5601
    elastic01.vm.network "forwarded_port", guest: 9200, host: 9200
    elastic01.vm.network "forwarded_port", guest: 9600, host: 9600
    elastic01.vm.synced_folder "./logstash-indexer", "/etc/logstash/conf.d"
  end
  config.vm.define "elastic02" do |elastic02|
    elastic02.vm.synced_folder "./logstash-indexer", "/etc/logstash/conf.d"
  end

end
