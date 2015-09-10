class maven::install (
	$mvn_dl_loc		=  	"http://10.50.20.26:8080/aaron/downloads/apache-maven-3.3.3-bin.tar.gz",
	$mvn_archive	=  	"apache-maven-3.3.3-bin.tar.gz",
	$mvn_dest		=	"/usr/bin/mvn",
	$mvn_folder		=	"apache-maven-3.3.3-bin"
) 
{
	Exec {
		path       	=>	[ "/usr/bin", "/bin", "/usr/sbin" ]
	}
	
	package { "wget":
		ensure     	=>	'installed',
	}
	
	exec { 'download archive':
		cwd	   		=>	'/tmp',
		command    	=>	"wget ${mvn_dl_loc}",
		onlyif		=>	"test ! -f ${mvn_dest}/installcompleted.txt",
		require		=>	Package['wget']
	}
	
#	file { "/tmp/${mvn_archive}" :
#		ensure	   	=>	"present",
#		source	   	=>	"",
	
	exec { 'extract mvn' :
		cwd	   		=>	"/tmp",
		command	   	=>	"tar -zxf ${mvn_archive}",
		onlyif		=>	"test ! -f ${mvn_dest}/installcompleted.txt",
		require		=>	Exec['extract mvn']
	}
	
	file { '${mvn_home}' :
		ensure	   	=>	directory,
		owner	   	=>	vagrant,
		require		=>	Exec['extract mvn']
	}
	
	exec { 'move mvn' :
		cwd			=>	'/tmp',
		creates		=>	$mvn_home,
		command		=>	"mv ${mvn_folder} ${mvn_dest}",
		onlyif		=>	"test ! -f ${mvn_dest}/installcompleted.txt",
		require		=>	Exec['${mvn_home}']
	}
	
	exec { 'install mvn' :
		logoutput	=>	true,
		command		=>	"update-alternatives --install /bin/mvn mvn ${mvn_home}/bin/mvn 1",
		onlyif		=>	"test ! -f ${mvn_dest}/installcompleted.txt",
		require		=>	Exec['move mvn']
	}
	
	exec { 'set mvn':
	  	logoutput 	=>	true,
		command   	=>	"update-alternatives --set mvn ${mvn_home}",
		onlyif		=>	"test ! -f ${mvn_dest}/installcompleted.txt",
		require		=>	Exec['install mvn']
	}
	
	file { "${mvn_dest}/installcompleted.txt":
	    ensure	  	=>  present,
		owner	  	=>	vagrant,
		mode	  	=>	0555,
		require   	=>	Exec['set javac']
	  }
}
