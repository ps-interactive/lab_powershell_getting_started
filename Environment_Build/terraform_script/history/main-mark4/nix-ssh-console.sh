#! /bin/bash

#################################################################################################Pluralsight Editing Only###########################################################################################

#timesyncd attempts to reach out to ntp.ubuntu.com but hangs because it gets not response, this will speed up overall loadtime.
systemctl stop systemd-timesyncd
systemctl disable systemd-timesyncd
# waits for proxy to be up and logs to script.test
echo "begin proxy test" >> script.test
response=\$$(sudo http_proxy=http://tstark:pssecrocks@172.31.245.222:8888 curl --write-out '%%{http_code}' --silent --output /dev/null www.google.com)
while [ \$$response -ne "200" ]; do
    echo \$$response >> script.test
    sleep 10
    response=\$$(sudo http_proxy=http://tstark:pssecrocks@172.31.245.222:8888 curl --write-out '%%{http_code}' --silent --output /dev/null www.google.com)
done
#once a positive 200 response is provided throughthe proxy to google, the peaceinourtime file is reated in the home folder. Note that the other files are created in the root folder.
echo "success">> /home/ubuntu/peaceinourtime




# Required install for console
sudo http_proxy=http://tstark:pssecrocks@172.31.245.222:8888 apt update
sudo http_proxy=http://tstark:pssecrocks@172.31.245.222:8888 apt -y install ec2-instance-connect
sudo http_proxy=http://tstark:pssecrocks@172.31.245.222:8888 apt -y install pwsh
##################################################################################################################################################################################################################

##################################################################################################################################################################################################################
#####################################################################################################CONTENT AUTHORING############################################################################################
##################################################################################################################################################################################################################
# Install additionally required software packages
#sudo http_proxy=http://tstark:pssecrocks@172.31.245.222:8888 apt -y install git
#sudo curl --proxy http://tstark:pssecrocks@172.31.245.222:8888 https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb >> /home/ubuntu/msfinstall 2>errors
#sudo chmod 755 /home/ubuntu/msfinstall
#sudo http_proxy=http://tstark:pssecrocks@172.31.245.222:8888 ./home/ubuntu/msfinstall

# Pull git repo for lab
#git -c http.proxy="http://tstark:pssecrocks@172.31.245.222:8888" clone https://github.com/arosenmund/ps-metasploit-lab.git /home/ubuntu/lab


#If a two way proxy is required enable the following code to allow access external to local ports


echo "Happy Hunting">> /home/ubuntu/peaceinourtime