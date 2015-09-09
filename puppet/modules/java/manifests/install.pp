class java::install (
	$java_dl_loc  =   "http://10.50.20.33:8080/aaron/downloads/jdk-8u45-linux-x64.tar.gz",
	$java_archive =   "jdk-8u45-linux-x64.tar.gz",
	$java_home    =   "/usr/lib/jvm/jdk1.8.0_45/",
	$java_folder  =   "jdk1.8.0_45"
)
{

	  Exec {
		path      =>  [ "/usr/bin", "/bin", "/usr/sbin" ]
 	  }

	  package { "wget":
	  	ensure    =>  "installed",
	  }

	  exec { 'download archive':
		cwd	      =>  '/tmp',
		command	  =>  "wget ${java_dl_loc}",
		require	  =>	Package["wget"]
	  }
 
#	  file { "/tmp/${java_archive}" :
#		ensure    =>  "present",
#		owner     =>  vagrant,
#		mode      =>  775,
#		require	  =>	Exec['download archive']
#	  }

	  exec { 'extract jdk':
		cwd       =>  '/tmp',
		command   =>  "tar xfv ${java_archive}",
		creates   =>  "${java_home}${java_archive}",
		require	  =>	Exec['download archive']
		#		require	  =>	File["/tmp/$(java_archive)"]
	  }

	  file { '/usr/lib/jvm' :
	  	ensure    =>  directory,
		owner     =>  vagrant,
		#require	  =>	File['/tmp/$(java_archive)']
		require	  =>	Exec['extract jdk']
	  }

	  exec {'move jdk':
	  	cwd       =>  '/tmp',
		command   =>  "mv ${java_folder} /usr/lib/jvm/",
		require	  =>   File['/usr/lib/jvm'],
	  }

	  exec { 'install java':
		logoutput =>  true,
		command   =>  "update-alternatives --install /bin/java java ${java_home}/bin/java 1",
		require	  =>	Exec['move jdk'],
	  }

	  exec {'set java':
	  	logoutput =>  true,
		command   =>  "update-alternatives --set java ${java_home}/bin/java",
		require	  =>	Exec['install java'],
	  }

	  exec { 'install javac':
		logoutput =>  true,
		command   =>  "update-alternatives --install /bin/javac javac ${java_home}/bin/javac 1",
		require   =>	Exec['set java'],
	  }

	  exec {'set javac':
	  	logoutput =>  true,
		command   =>  "update-alternatives --set javac ${java_home}/bin/javac",
		require   =>	Exec['install javac'],
	  }

	  file { "/etc/profile.d/java.sh":
	    ensure	  =>  present,
		content   =>  "export JAVA_HOME=${java_home}
					   export PATH=\$PATH:\$%JAVA_HOME%/bin",
		owner	  =>	vagrant,
		mode	  =>	0555,
		require   =>	Exec['set javac']
	  }
}
