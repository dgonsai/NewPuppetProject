class docker::install 
{
	exec { 'update packages':
	cwd => '/opt',
	command => 'apt-get update',
	}
	
	exec { 'install docker package':
	command => 'apt-get -y install docker.io',
	require => Exec['update packages']
	}
	
	exec { 'symbolic link docker':
	command => 'sudo ln -sf /usr/bin/docker.io /usr/local/bin/docker',
	require => Exec['install docker package']
	}
	
	exec { 'docker io creation':
	command => "sed -i '$acomplete -F _docker docker' /etc/bash_completion.d/docker.io",
	require => Exec['symbolic link docker']
	}
	
	exec { 'update docker to run on system start-up':
	command => 'update-rc.d docker.io defaults',
	require => Exec['docker io creation']
	}
	
	exec { 'firewall port exception':
	command => 'ufw allow 2375/tcp',
	require => Exec['update docker to run on system start-up']
	}
	
	exec { 'run docker':
	command => 'docker run hello-world',
	require => Exec['firewall port exception']
	}
}