masterIP = '10.50.15.123'
agentIP  = '10.50.115.124'

Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  
  # Unbuntu operating system, added from the predownloaded set of boxes
   config.vm.box = "ubuntu/trusty64"
   
  # setting the size of memory the mcahine has, along with the number of cpus
   config.vm.provider "virtualbox" do |vb|
	# RAM
	vb.memory = 2056
	# Number of cores
	vb.cpus = 2
   end
   
<<<<<<< HEAD
  # running the bootstrap bash file (all it does atm is apt-get update)
   config.vm.provision :shell, path: "bootstrap.sh"
     
  # Creating a synced folder, creating a live link between the 
  # puppet foleder and the /opt/puppet folder on the machine
   config.vm.synced_folder "puppet", "/opt/puppet"
      
  # using the build in vagrant provisioing achitechture 
  # setting the atrobutes of the puppet files/modules
	config.vm.provision "puppet" do |puppet|
		# attempting to the create the linke between master and agent,by using the vagrant
		# provisioing architechture
		# puppet.puppet_server  = "master.netbuilder.private"
		# puppet.puppet_node    = "agent001.netbuilder.private"
		# setting the location of the puppet manifest file
		puppet.manifests_path = "puppet/manifests"
		# setting the location of the puppet module file
		puppet.module_path    = "puppet/modules"
		# defining the name of the default.pp or site.pp file 
		puppet.manifest_file  = "default.pp"
	end

	config.vm.define "Master" do |master|
		# setting the network type of the machine and appling a static ip address   
		master.vm.network :public_network, ip: masterIP
		master.vm.hostname = "master" 
		# running the jenkins bash script, the bash file added jenkins keys to the apt folder
		# and calls it with the apt-get commad 
		master.vm.provision :shell, path: "jenkins_provisions.sh"
	end
  
	config.vm.define "Agent001" do |agent001|
		agent001.vm.network :public_network, ip: agentIP
		agent001.vm.hostname = "agent001"
	end
end
=======




  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   sudo apt-get update
  #   sudo apt-get install -y apache2
  # SHELL

end


config.vm.provision "puppet" do |puppet|
   #puppet.puppet_server  = "master.netbuilder.private"
   #puppet.puppet_node    = "agent001.netbuilder.private"
    puppet.manifests_path = "puppet/manifests"
    puppet.module_path    = "puppet/modules"
    puppet.manifest_file  = "default.pp"
end


config.vm.define "agent001" do |agent001|
	agent001.vm.network :public_network, ip: agentIP
	agent001.vm.hostname = "agent001"
end
>>>>>>> fe85be8794c74bf0043a0d37186c98cc551343c0
