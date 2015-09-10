class jira::install {

  Exec {
    path => ["/bin", "/usr/bin", "/usr/sbin"]
  }

  file { "${jira::INSTALL_DIR}" :
    ensure => 'directory',
	before => File['download jira'],
  }

  file { 'download jira':
    path    => "${jira::INSTALL_DIR}${jira::EXEC_FILE}",
    ensure  => 'present',
    source  => "puppet:///modules/jira/${jira::EXEC_FILE}",
    mode    => 755,
  }

  exec { 'install jira':
    command => "${jira::INSTALL_DIR}${jira::EXEC_FILE} -q",
	creates => '/opt/atlassian/jira',
    require => File['download jira'],
  }

}