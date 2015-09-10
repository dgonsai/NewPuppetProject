class jira::install{
	
	Exec {
		path => ["/bin", "/usr/bin", "/usr/sbin"]
	}
	
	#downloading the Jira bin file
	exec{'Download Jira':
	    cwd => '/opt',
		command => 'sudo wget http://10.50.15.26:8080/aaron/downloads/atlassian-jira-6.4.9-x64.bin',
		timeout => 0, #ensure the download has enough time to fully download
	}
	
	#change mod to change access permissions to everyone
	exec{'change mod':
	    cwd => '/opt',
		command => 'sudo chmod +x atlassian-jira-6.4.9-x64.bin',
		require => Exec['Download Jira'],
	}
	
	#install the downloaded bin file
	exec{'install jira':
	    cwd => '/opt',
		command => 'printf "" | sudo ./atlassian-jira-6.4.9-x64.bin',
		require => Exec['change mod'],
		timeout => 0, #ensure the install has enough time to fully install
	}
	
	#stopping the jira service for configuration
	exec{'stop jira':
		cwd => '/opt',
		command => 'sudo service jira stop',
		require => Exec['install jira'],
	}
	
	#change the port from 8080 to 8082
	exec{'change port':
		cwd => '/opt',
		command => 'sudo sed -i s/8080/8082/g /opt/JIRA/conf/server.xml',
		require => Exec['stop jira'],
	}
	
	#start the jira service
	exec{'start jira':
		cwd => '/opt',
		command => 'sudo service jira start',
		require => Exec['change port'],
	}
}