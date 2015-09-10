class zabbix::install {
  Exec {
    path => ["/bin", "/usr/bin", "/usr/sbin", "/usr/local/sbin","/sbin"]
  }

  file { "${zabbix::INSTALL_DIR}zabbix.deb":
    ensure => 'present',
    source => 'puppet:///modules/zabbix/zabbix.deb',
	before => Exec['update repo'],
  }
  
  exec { 'update repo':
    cwd     => "${zabbix::INSTALL_DIR}",
	command => 'dpkg -i zabbix.deb && apt-get update',
	before  => Package['zabbix-frontend-php'],
  }
  
  package { ['zabbix-server-mysql','zabbix-frontend-php']:
    ensure => 'installed',
  }
  
  service { 'apache2':
    ensure    => 'running',
	require   => Package['zabbix-frontend-php'],
	subscribe => File_Line['configure lang'],
  }
}