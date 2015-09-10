class nexus::install(
  $nexus_archive = "nexus-latest-bundle.tar.gz",
  $nexus_home = "/opt/nexus-latest-bundle",
  $nexus_folder = "nexus-latest-bundle"){
  
  Exec {
    path => ['/usr/bin', '/bin', '/usr/sbin']
  }
  
  exec { 'download nexus' :
    command => "sudo wget http://www.sonatype.org/downloads/nexus-latest-bundle.tar.gz",
  }
  
  exec { 'extract nexus' :
	command => "sudo tar zxvf ${nexus_archive}",
	creates => $nexus_home,
	require => Exec['download nexus'],
  }
  
  exec { 'move nexus' :
	require => Exec['extract nexus'],
	command => "sudo mv nexus-2.11.4-01/ /usr/local/"
  }
	
  exec { 'move nexus work' :
	require => Exec['move nexus'],
	command => "sudo mv sonatype-work/ /usr/local/",
  }
  
  exec { 'nexus ln' :
	require => Exec['move nexus work'],
	cwd     => '/usr/local/',
	command => "sudo ln -s nexus-2.11.4-01 nexus",
  }
  
  exec { 'add user' :
	require => Exec['nexus ln'],
	cwd     => '/usr/local/nexus',
	command => "sudo adduser -disabled-password -disabled-login nexus",
  }
	
  exec { 'change owner' :
	require => Exec['add user'],
	command => "sudo chown -R nexus:nexus /usr/local/nexus-2.11.4-01/",
  }
  
  exec { 'change owner-work' :
	require => Exec['change owner'],
	command => "sudo chown -R nexus:nexus /usr/local/sonatype-work/",
  }

  exec { 'start nexus' :
	require => Exec['change owner-work'],
	cwd     => '/usr/local/nexus',
	command => "sudo su nexus -c './bin/nexus start'",
  }	
}    