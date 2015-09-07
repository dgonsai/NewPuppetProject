#-----------------------
## -Installing Nexus
#-----------------------
wget http://www.sonatype.org/downloads/nexus-latest-bundle.tar.gz
tar zxvf nexus-latest-bundle.tar.gz

#-----------------------
## -Nexus Move
#-----------------------
mv nexus-2.11.4-01/ /usr/local/
mv sonatype-work/ /usr/local/

#-----------------------
## -Nexus ln
#-----------------------
cd /usr/local/
ln -s nexus-2.11.4-01 nexus

#-----------------------
## -Add test user/change owners
#-----------------------
cd /usr/local/nexus
adduser -disabled-password -disabled-login nexus
chown -R nexus:nexus /usr/local/nexus-2.11.4-01/
chown -R nexus:nexus /usr/local/sonatype-work/

#-----------------------
## -Start Nexus
#-----------------------
su nexus -c "./bin/nexus start"