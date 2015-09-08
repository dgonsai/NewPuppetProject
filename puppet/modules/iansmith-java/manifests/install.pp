class install {
	$java_dl_loc  =   "http://10.50.15.14:8080/aaron/downloads/jdk-8u45-linux-x64.tar.gz"
	$java_archive =   "jdk-8u45-linux-x64.tar.gz",
	$java_home    =   "/usr/lib/jvm/jdk1.8.0_48/",
	$java_folder  =   "jdk1.8.0_48"

	{
	  Exec {
		path      =>  [ "/usr/bin", "/bin", "/usr/sbin" ]
 	  }->

	  package { "wget":
	  	ensure    =>  "installed"
	  }->

	  exec { 'download archive':
		cwd	      =>  '/tmp',
		command	  =>  "wget ${java_dl_loc}",
	  }->
 
	  file { "/tmp/$(java_archive)" :
		ensure    =>  "present",
		source    =>  "puppet:///modules/java/$(java_archive)"
		owner     =>  vagrant,
		mode      =>  775
	  }->

	  exec { 'extract jdk':
		cwd       =>  '/tmp',
		command   =>  "tar xfv ${java_archive}",
		creates   =>  ${java_home}
	  }->

	  file { '/usr/lib/jvm' :
	  	ensure    =>  directory,
		owner     =>  vagrant,
	  }->

	  exec {'move jdk':
	  	cwd       =>  '/tmp',
		creates   =>  $java_home,
		command   =>  "mv ${java_folder} /usr/lib/jvm/"
	  }->

	  exec { 'install java':
		logoutput =>  true,
		command   =>  "update-alternatives --install /bin/java java ${java_home}/bin/java 1"
	  }->

	  exec {'set java':
	  	logoutput =>  true,
		command   =>  "update-alternatives --set java ${java_home}/bin/java"
	  }->

	  exec { 'install javac':
		logoutput =>  true,
		command   =>  "update-alternatives --install /bin/javac javac ${java_home}/bin/javac 1"
	  }->

	  exec {'set javac':
	  	logoutput =>  true,
		command   =>  "update-alternatives --set javac ${java_home}/bin/javac"
	  }->

	  file { "/etc/profile.d/java.sh":
	    content   =>  "export JAVA_HOME=${java_home}
					   export PATH=\$PATH:\$JAVA_HOME/bin"
	  }
}
