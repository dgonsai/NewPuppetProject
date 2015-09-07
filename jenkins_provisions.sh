##!/usr/bin/env bash#

#wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
#sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
#sudo apt-get update -y
#sudo apt-get install jenkins -y

#sudo service jenkins status
#sudo service jenkins start
#!/bin/bash
 
###
# 
# Copyright (c) 2013 KimSia Sim
# 
# Ubuntu 12.10 based install jenkins and other related plugins
# Run this by executing the following from a fresh install of Ubuntu 12.10 server:
# 
#     bash -c "$(curl -fsSL https://gist.github.com/simkimsia/4473000/raw/5e301a3bd399096e7cbbe3b1a877997a117aa7a3/install-jenkins-on-ubuntu-12-10.sh)"
# 
# Also, run this as root, unless you enjoy failing.
# 
# Its handy to install 'screen' if you want to ensure your remote connection to
# a server doesn't disrupt the installation process. If you want to do this, just
# do the following before running the main bash command:
# 
#     apt-get install screen -y
#     screen
# 
# To recover your session if you are disconnected, ssh to your server as root again,
# and type:
# 
#     screen -x
# 
# Dependencies:
# - curl
# 
# Todo:
# - SSL Configuration
# 
###
 
##########################
## Install Jenkins
##########################
wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
apt-get update -y
apt-get install jenkins -y

##########################
## Install Git if not already done so
##########################
apt-get install git-core --force-yes -y

##########################
## Add user `jenkins` to the sudoers and www-data groups
##########################
adduser jenkins sudo
adduser jenkins www-data

##########################
## Because `jenkins` service is now running 
## AND we have added `jenkins` to new groups
## SO we need to restart the service
##########################
echo "Restarting Jenkins..."
service jenkins restart

##########################
## Sleep for about 10s before we start to update plugin shortnames
##########################
echo "Hi, I'm sleeping for 10 seconds... before updating plugin shortnames"
sleep 10s

####################################################################################
## Need to update all the plugin shortnames from the Jenkins update center first
## hat tip to https://gist.github.com/1026918#comment-61254
####################################################################################
curl  -L http://updates.jenkins-ci.org/update-center.json | sed '1d;$d' | curl -X POST -H 'Accept: application/json' -d @- http://localhost:8080/updateCenter/byId/default/postBack
