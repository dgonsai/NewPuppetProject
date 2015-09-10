 class jenkins::install {

  Exec {
    path => ["/bin", "/usr/bin", "/usr/sbin", "/usr/local/sbin","/sbin"]
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
  
  service { 'jenkins':
    ensure => 'running',
  }
 
  #Create a dependency to evoke apt update before package
  Exec['apt-get update'] -> Package <| |>
}