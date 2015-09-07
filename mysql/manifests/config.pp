class mysql::config {
  #Create a home directory for bamboo settings
  file{ 'create home' :
    path   => '/home/vagrant/bamboo',
    ensure => 'directory',
	before => File_Line['configure home']
  }
  
  #Configure bamboo adding the link to home directory
  file_line { 'configure home':
    path    => "${bamboo::INSTALL_DIR}atlassian-bamboo-${bamboo::VERSION}/atlassian-bamboo/WEB-INF/classes/bamboo-init.properties",
    line    => 'bamboo.home=/home/vagrant/bamboo',
    match   => 'bamboo.home=', #replace line that matches
	before  => Exec['bamboo start']
  }
  
  #Finally, start bamboo via shell
  exec { 'bamboo start':
    path     => "${bamboo::INSTALL_DIR}atlassian-bamboo-${bamboo::VERSION}/bin",
	command => "./start-bamboo.sh &"
  }
}
