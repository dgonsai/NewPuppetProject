class maven::install (
	$mvn_dl_loc		=  	"http://10.50.20.26:8080/aaron/downloads/apache-maven-3.3.3-bin.tar.gz",
	$mvn_archive	=  	"apache-maven-3.3.3-bin.tar.gz",
	$mvn_folder		=	"apache-maven-3.3.3"
) 
{
	Exec {
		path       	=>	[ "/usr/bin", "/bin", "/usr/sbin" ]
	}
	
	
	exec { 'download mvn archive':
		cwd	   		=>	'/tmp',
		command    	=>	"wget ${mvn_dl_loc}",
		onlyif		=>	"test ! -f /etc/profile.d/mvn.sh",
		require		=>	Class['java::install']
	}
	
	exec { 'extract mvn' :
		cwd	   		=>	"/tmp",
		command	   	=>	"tar -zxf ${mvn_archive}",
		onlyif		=>	"test ! -f /etc/profile.d/mvn.sh",
		require		=>	Exec['download mvn archive']
	}
	
	exec { 'install mvn' :
		logoutput	=>	true,
		command		=>	"update-alternatives --install /usr/bin/mvn mvn /tmp/${mvn_folder}/bin/mvn 3",
		onlyif		=>	"test ! -f /etc/profile.d/mvn.sh",
		require		=>	Exec['extract mvn']
	}
	
	file { "/etc/profile.d/mvn.sh" :
		content 	=> 'export MAVEN_HOME=/usr/bin/mvn
export PATH=$PATH:$MAVEN_HOME/bin',
		ensure  	=> 	present,
		owner	  	=>	vagrant,
		mode	  	=>	0744,
		require   	=>	Exec['install mvn']
	}
}
