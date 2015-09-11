class git::install (
	$git_dl_loc 	= 	"http://10.50.20.26:8080/aaron/downloads/git-2.5.0.tar.gz", 
	$git_archive 	= 	"git-2.5.0.tar.gz",
	$git_folder		=	"git-2.5.0"
)
{
	Exec {
		path		=>	[ "/usr/bin", "/bin", "/usr/local/sbin", "/sbin", "usr/sbin" ]
	}
	
	exec { 'aptget update' :
		command 	=>	"apt-get update",
		onlyif 		=> 	"test ! -f /etc/puppet/modules/git/files/installcompleted.txt",
		require		=>	Class['maven::install']
	}
	
	exec { 'install git dependencies' :
		command 	=>	"apt-get install -y libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev autoconf",
		onlyif 		=> 	"test ! -f /etc/puppet/modules/git/files/installcompleted.txt",
		require		=>	Exec['aptget update']
	}
	
	exec { 'download git archive':
		cwd 		=> '/tmp',
		command 	=> "wget ${git_dl_loc}",
		onlyif 		=> "test ! -f /etc/puppet/modules/git/files/installcompleted.txt",
		require 	=> Exec['install git dependencies']
	}
		
	exec { 'extract git' :
		cwd 		=> 	"/tmp",
		command 	=> 	"tar -zxf ${git_archive}",
		onlyif 		=> 	"test ! -f /etc/puppet/modules/git/files/installcompleted.txt",
		require 	=> 	Exec['download git archive']
	}

	exec { 'install git' :
		logoutput	=>	true,
		cwd			=>	"/tmp/${git_folder}",
		command 	=> 	"make configure && ./configure --prefix=/usr && make install",
		onlyif 		=> 	"test ! -f /etc/puppet/modules/git/files/installcompleted.txt",
		require 	=> 	Exec['extract git']
	}
	
	file { "/etc/puppet/modules/git/files/installcompleted.txt":
	    ensure 		=> present,
		owner 		=> vagrant,
		mode		=> 0555,
		require 	=> Exec['install git']
	}
}
