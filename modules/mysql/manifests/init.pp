class mysql {
  #Global (class specific) variables that are used in Install and Config
  
  $PACKAGES = ['mysql-server','mysql-client']
  
  include mysql::install
}
