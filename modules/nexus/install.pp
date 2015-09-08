class nexus::install{

	Exec {
		path => ['/usr/bin', '/bin', '/usr/sbin']
	}
	
	exec{'download nexus':
		command => 'sudo wget http://www.sonatype.org/downloads/nexus-latest-bundle.tar.gz',
	}
	
	exec{'extract nexus':
		command => 'sudo tar zxvf nexus-latest-bundle.tar.gz',
		require => Exec['download nexus'],
	}
	
	exec{'move nexus':
		command => 'sudo mv nexus-2.11.4-01/ /usr/local/',
		require => Exec['extract nexus'],
	}
	
	exec{'move sonatype':
		command => 'sudo mv sonatype-work/ /usr/local/',
		require => Exec['move nexus'],
	}
	
	exec{'nexus ln':
		cwd => '/usr/local/',
		command => 'sudo ln -s nexus-2.11.4-01 nexus',	
	}
	
	exec{'add user':
		require => Exec['nexus ln'],
		cwd => '/usr/local/nexus',
		command => "sudo adduser -disabled-password -disabled-login nexus",
	}
	
	exec{'change owner' :
		require => Exec['add user'],
		command => "sudo chown -R nexus:nexus /usr/local/nexus-2.11.4-01/",
	}
    
	exec { 'change owner-work' :
		require => Exec['change owner'],
		command => "sudo chown -R nexus:nexus /usr/local/sonatype-work/",
	}
	
	exec { 'run nexus server':
		cwd => '/opt/nexus/nexus/bin',
		command => './nexus console start',
		require => Exec["change owner-work"]
	}
}