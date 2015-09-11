The Third CI Project 

This project is a demonstration of installing and configuring various CI tools using Vagrant and PUppet. Jira 
is used to track the process of the project. 

Requirements 
- Vagrant version 1.2.0 or greater

CI Tools used for this Project 
- Vagrant 
- Puppet 
- Jira
- Docker
- Maven 
- Java 
- Zabbix
- Nexus 

Usage 

Master Vagrant File

This vagrant file create the master with a static ip address and provistions puppet creation the puppet file 
structure, the site.pp file is called the default.pp but working the same way. Following the master machine creatation,
the agent machine will be created and provisioned with the master's modules.    