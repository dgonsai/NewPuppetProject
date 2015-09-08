class jira::install{
	
	Exec{
        path => ['/usr/bin', 'bin', '/usr/sbin'], provider => 'shell'
    }
	
	exec{'Download Jira':
	    cwd => '/opt',
		command => 'sudo wget http://10.50.20.28:8080/aaron/downloads/atlassian-jira-6.4.9-x64.bin',
		timeout => 0,
	}
	
	exec{'change mod':
	    cwd => '/opt',
		command => 'sudo chmod +x atlassian-jira-6.4.9-x64.bin',
		require => Exec['Download Jira'],
	}
	
	exec{'install jira':
	    cwd => '/opt',
		command => 'sudo ./atlassian-jira-6.4.9-x64.bin -q',
		require => Exec['change mod'],
	}
	
	exec{'stop jira':
		cwd => '/opt',
		command => 'sudo service jira stop',
		require => Exec['install jira'],
	}
	
	exec{'change port':
		cwd => '/opt',
		command => 'sudo sed -i 's/8080/8082/g' /opt/JIRA/conf/server.xml',
		require => Exec['stop jira'],
	}
	
	exec{'start jira':
		cwd => '/opt',
		command => 'sudo service jira start',
		require => Exec['change port'],
	}
}