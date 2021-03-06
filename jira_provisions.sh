#-----------------------
## -Installing Jira
#-----------------------
cd /opt
wget http://10.50.20.28:8080/aaron/downloads/atlassian-jira-6.4.9-x64.bin
chmod +x atlassian-jira-6.4.9-x64.bin
./atlassian-jira-6.4.9-x64.bin -q

#-----------------------
## -Change Port
#-----------------------
service jira stop
sed -i 's/8080/8082/g' /opt/JIRA/conf/server.xml
service jira start
