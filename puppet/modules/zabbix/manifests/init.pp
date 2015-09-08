class zabbix {
  #Global (class specific) variables that are used in Install and Config
  $INSTALL_DIR = "/tmp/"
  
  include zabbix::install
  include zabbix::config
}