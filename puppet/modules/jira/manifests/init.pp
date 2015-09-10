class jira {
  $INSTALL_DIR = "/usr/local/jira/"
  $EXEC_FILE = "atlassian-jira-6.4.11-x64.bin"
  
  include jira::install
}
