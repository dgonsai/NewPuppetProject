class mysql::install {
  Exec {
    path => ["/bin", "/usr/bin", "/usr/sbin"]
  }

  #Download and install neccesary packages
  package { $mysql::PACKAGES :
    ensure => 'installed',
	#source => "${mysql::INSTALL_DIR}${mysql::ARCHIVE}",
	before => Service['mysql'],
  }
  
  service {'mysql' :
    ensure => 'running',
  }
}
