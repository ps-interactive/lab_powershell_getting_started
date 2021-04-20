#! /bin/bash  ####THIS IS NOT FULLY TESTED ON RHEL BUILD AS OF THIS TEMPLATE RELEASE!!!!!
#TEMLATE: v3.0 4-17-2020 ironcat
######################################Pluralsight Editing Only#######################################################################################
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
# Install git LAB_FILES
sudo http_proxy=http://tstark:pssecrocks@172.31.245.222:8888 apt -y install git
#Pull git repo for lab if your lab has lab files a repo will need to be created and the file uploaded under a "LAB_FILES"  folder to end up here:
#git -c http.proxy="http://tstark:pssecrocks@172.31.245.222:8888" clone https://github.com/arosenmund/ps-metasploit-lab.git /home/ubuntu/lab

##################################################################################################################################################################################################################
##########CONTENT AUTHORING  Edit to setup Application below this line############################################################################################
##################################################################################################################################################################################################################
# Install additionally required software packages
# Repo install - Ubuntu
# Example1 - sudo http_proxy=http://tstark:pssecrocks@172.31.245.222:8888 apt install -y docker.io
# Example2 - Bypassing Acknoledgement Requirments - #sudo http_proxy=http://tstark:pssecrocks@172.31.245.222:8888 DEBIAN_FRONTEND=noninteractive apt -y --force-yes install mysql-server
#
#
#########################################################################################################
# Curl pacakge adn install from binary
# Example - 
#           sudo curl --proxy http://tstark:pssecrocks@172.31.245.222:8888 https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb >> /home/ubuntu/msfinstall 2>errors
#           sudo chmod 755 /home/ubuntu/msfinstall
#           sudo http_proxy=http://tstark:pssecrocks@172.31.245.222:8888 ./home/ubuntu/msfinstall
#
#
##########################################################################################################
# Use Docker or Docker Compose
# 
#
# Depednecy - sudo http_proxy=http://tstark:pssecrocks@172.31.245.222:8888 apt install -y docker.io && sudo http_proxy=http://tstark:pssecrocks@172.31.245.222:8888 apt install -y docker-compose
        #   sudo mkdir -p /etc/systemd/system/docker.service.d
        #   sudo echo "[Service]" >> /etc/systemd/system/docker.service.d/proxy.conf
        #   sudo echo "Environment=\"HTTP_PROXY=http://tstark:pssecrocks@172.31.245.222:8888\"" >> /etc/systemd/system/docker.service.d/proxy.conf
        #   sudo echo "Environment=\"HTTPS_PROXY=http://tstark:pssecrocks@172.31.245.222:8888\"" >> /etc/systemd/system/docker.service.d/proxy.conf
        #   sudo echo "Environment=\"NO_PROXY=localhost,127.0.0.1,::1\"" >> /etc/systemd/system/docker.service.d/proxy.conf
        #   sudo systemctl daemon-reload
        #   sudo systemctl restart docker
#   #docker commands now work "docker pull" etc.
    #
            #docker compose project from github
        #   sudo git -c http.proxy="http://tstark:pssecrocks@172.31.245.222:8888" clone https://github.com/arosenmund/ps-metasploit-lab.git
        #   cd ps-metasploit-lab/dvwp
        #   sudo chmod +x bin/install-wp.sh
        #   sudo docker-compose up -d --build
        #   sudo docker-compose run --rm wp-cli install-wp
#
#
# Use git to clone a project
# Make a file pulled from the internet or downloaded from a repo
# Example - # download gucamole server
#           sudo http_proxy=http://tstark:pssecrocks@172.31.245.222:8888 wget https://mirrors.sonic.net/apache/guacamole/1.3.0/source/guacamole-server-1.3.0.tar.gz
#           tar -xvf guacamole-server-1.3.0.tar.gz
#           move it so you know where it is, commands run as root in "/" always us absolute references
#           sudo mv guacamole-server-1.3.0 /opt/guacamole-server
#           sudo autoreconf -vfi
#           cd /opt/guacamole-server #watch this, the cwd may not operate properly here
#           sudo ./configure --with-init-dir=/etc/init.d
#           sudo make
### This will be slow...if you need this to come up with more speed you can pre-make in the envionrment and then place in github repo.
#           sudo make install
#           sudo ldconfig
#           sudo systemctl daemon-reload
#           sudo systemctl start guacd
##END AUTHOR EDITING DELETE WHAT YOU DO NOT NEED IN THIS SECTION####################################################################


# End message for PS DO NOT EDIT
echo "Happy Hunting">> /home/ubuntu/peaceinourtime