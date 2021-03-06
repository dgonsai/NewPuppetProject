 class jenkins::install {

  Exec {
    path => ["/bin", "/usr/bin", "/usr/sbin", "/usr/local/sbin","/sbin"]
  }
  
  exec { 'update key':
    command => 'wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | apt-key add - ',
	before  => Exec['apt-get clean'],
  }

  file { 'update sources':
    path => '/etc/apt/sources.list.d/jenkins.list',
	ensure => 'present',
    source => "puppet:///modules/jenkins/jenkins.list",
  }
  
  exec { 'apt-get update':
    require => File['update sources'],
	before  => Exec['apt-get clean'],
  }
  
  exec { 'apt-get clean':
	require => File['update sources'],
	before  => Package['jenkins'],
  }
  
  package{ 'jenkins':
    ensure => 'installed',
	before => Service['jenkins'],
  }
  
  file_line { 'change port':
    path    => '/etc/default/jenkins',
    line    => 'HTTP_PORT=8081',
    match   => '^HTTP_PORT', #replace line that matches
	require => Package['jenkins'],
	notify  => Service['jenkins'],
  }
  
  service { 'jenkins':
    ensure => 'running',
  }
 
  #Create a dependency to evoke apt update before package
  Exec['apt-get update'] -> Package <| |>
}