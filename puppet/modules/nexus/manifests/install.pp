class nexus::install{

	Exec {
		path => ["/bin", "/usr/bin", "/usr/sbin"]
	}
	
	#downloading the nexus tar file
	exec{'download nexus':
		command => 'sudo wget http://www.sonatype.org/downloads/nexus-latest-bundle.tar.gz',
	}
	
	#extracting the tar file
	exec{'extract nexus':
		command => 'sudo tar zxvf nexus-latest-bundle.tar.gz',
		require => Exec['download nexus'],
	}
	
	#moving the nexus folder to the usr/local directory
	exec{'move nexus':
		command => 'sudo mv nexus-2.11.4-01/ /usr/local/',
		require => Exec['extract nexus'],
	}
	
	#moving the sonatype folder to the usr/local directory
	exec{'move sonatype':
		command => 'sudo mv sonatype-work/ /usr/local/',
		require => Exec['move nexus'],
	}
	
	#linking the nexus-2.11.4-01 folder to nexus
	exec{'nexus ln':
		cwd => '/usr/local/',
		command => 'sudo ln -s nexus-2.11.4-01 nexus',	
	}
	
	#adding a user for testing - no password or login
	exec{'add user':
		require => Exec['nexus ln'],
		cwd => '/usr/local/nexus',
		command => "sudo adduser -disabled-password -disabled-login nexus",
	}
	
	#changing the owner of the nexus folder
	exec{'change owner' :
		require => Exec['add user'],
		command => "sudo chown -R nexus:nexus /usr/local/nexus-2.11.4-01/",
	}
    
	#changing the owner of the sonatype folder
	exec { 'change owner-work' :
		require => Exec['change owner'],
		command => "sudo chown -R nexus:nexus /usr/local/sonatype-work/",
	}
	
	#start the nexus service in console
	# --works without spamming the console! --#
	exec {'run nexus server':
		cwd => '/opt/nexus/nexus/bin',
		command => './nexus console start',
		require => Exec["change owner-work"]
	}
}
