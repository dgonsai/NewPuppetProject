class zabbix::config {

  #Configure zabbix file
  file_line { 'configure lang':
    path    => '/etc/apache2/conf-available/zabbix.conf',
    line    => "\tphp_value date.timezone Europe/London",
    match   => 'date.timezone', #replace line that matches
    require => Package['zabbix-frontend-php'],
  }
 
}