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




